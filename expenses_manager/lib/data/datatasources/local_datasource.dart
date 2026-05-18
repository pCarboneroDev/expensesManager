import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/database/sqlite_handler.dart';
import 'package:expenses_manager/data/entities/category_entity.dart';
import 'package:expenses_manager/data/entities/transaction_entity.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  final SqliteHandler handler;
  Database? _db;

  LocalDatasource({required this.handler});
  
  get where => null;

  Future<void> init() async {
    _db = await handler.getDb();
  }

  // Future<Database> openDatabaseFromAssets() async {
  //   // Get the temporary directory (cache)
  //   final directory = await getTemporaryDirectory();
  //   final path = join(directory.path, 'mi_app.db');

  //   // Check if the database file exists
  //   final exists = await File(path).exists();

  //   if (!exists) {
  //     // Copy from assets
  //     ByteData data = await rootBundle.load('assets/db/mi_app.db');
  //     List<int> bytes = data.buffer.asUint8List(
  //       data.offsetInBytes,
  //       data.lengthInBytes,
  //     );

  //     // Write and flush the bytes written
  //     await File(path).writeAsBytes(bytes, flush: true);
  //   }

  //   // Open the database
  //   return await openDatabase(path);
  // }

  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final response = await _db?.query("categories");

      if (response == null || response.isEmpty) {
        return Left(DataSourceException("No categories found"));
      }

      final List<CategoryModel> categories = response.map((row) {
        return CategoryEntity.fromMap(row).toModel();
      }).toList();

      return Right(categories);
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }


  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions({
    int? skip,
    int? limit,
    int? categoryId,
    String date = 'month',
  }) async {
    try {
      List<Map<String, Object?>>? response;
      final dateLower = date.toLowerCase();
      String dateFilter = DateTime.now().month.toString();

      String query = '''SELECT t.*, c.name as category_name FROM transactions t LEFT JOIN categories c ON t.id_category = c.id''';

      List<String> args = [];

      if (dateLower == 'month'){
        final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
        query += ''' WHERE strftime('%m', t.date) = ?''';
        args.add(currentMonth);
      }
      else if (dateLower == 'year'){
        final currentYear = DateTime.now().year.toString();
        query += ''' WHERE strftime('%Y', t.date) = ?''';
        args.add(currentYear);
      }
      else if (dateLower == 'week'){
        final (startOfWeek, endOfWeek) = _getCurrentWeekRange();

        query += ''' WHERE t.date <= ? AND t.date >= ?''';

        args.add(endOfWeek.toString());
        args.add(startOfWeek.toString());
      }

      // if(dateLower != 'week'){
      //   final query = '''
      //     SELECT t.*, c.name as category_name
      //     FROM transactions t
      //     LEFT JOIN categories c ON t.id_category = c.id
      //   ''';
      //   response = await _db?.rawQuery(query); 
      // }
      if (categoryId != null && categoryId != 0) {
        query += " AND id_category = ?";
        args.add(categoryId.toString());
      }

      print(query);

      response = await _db?.rawQuery(query, args); 

      if(response == null){
        return Right([]);
      } 

      final List<TransactionModel> transactions = response.map((row) {
        return TransactionEntity(
          id: row['id'] as int, 
          date: DateTime.parse(row['date'] as String), 
          userId: "",
          amount: row['amount'] as double, 
          category: CategoryEntity(id: row['id_category'] as int, name: row['category_name'] as String), 
          type: TransactionType.fromString(row['transaction_type'] as String)
        ).toModel();
      }).toList();


      return Right(transactions);

    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionModel newTransaction,
  ) async {
    try {
      final response = await _db?.insert('transactions', {
        'date': newTransaction.date.toString(),
        'amount': newTransaction.amount,
        'id_category': newTransaction.category.id,
        'transaction_type': newTransaction.type.name,
      });

      if (response == null) {
        return Left(DataSourceException("Error: response is null"));
      }

      if (response > 0) {
        return Right(newTransaction);
      } else {
        return Left(DataSourceException("Error: response is 0"));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteTransaction(int transactionId) async {
    try {
      final response = await _db?.delete("transactions", where: 'id = ?', whereArgs: [transactionId]);

      if (response == null || response <= 0){
        return Left(DataSourceException("ERROR: response is null or 0"));
      }
      return Right(true);
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

    Future<Either<Failure, TransactionModel>> updateTransaction(
    int transactionId,
    TransactionModel transaction,
  ) async {
    try {

      final response = await _db?.update(
        'transactions',
        {
          'date': transaction.date,
          'amount': transaction.amount,
          'categoryId': transaction.category.id,
          'type': transaction.type.name,
        },
        where: 'id = ?',
        whereArgs: [transactionId]
      );

      if (response == null || response <= 0){
        return Left(DataSourceException("ERROR: response is null or 0"));
      }
      return Right(transaction);
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  (DateTime startOfWeek, DateTime endOfWeek) _getCurrentWeekRange() {
    final now = DateTime.now();
    final weekday = now.weekday;
    
    // Calcular el Lunes de la semana actual
    // weekday: 1 = Lunes, 7 = Domingo
    final startOfWeek = now.subtract(Duration(days: weekday - 1));
    
    // Ajustar para que empiece a las 00:00:00
    final startOfDay = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    // Calcular el Domingo (Lunes + 6 días)
    final endOfWeek = startOfDay.add(const Duration(days: 6));
    
    // Ajustar para que termine a las 23:59:59.999
    final endOfDay = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59, 999);
    
    return (startOfDay, endOfDay);
  }
}
