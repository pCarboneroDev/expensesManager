import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expenses_manager/data/entities/category_entity.dart';
import 'package:expenses_manager/data/entities/create_transaction_dto.dart';
import 'package:expenses_manager/data/entities/transaction_entity.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';

class RemoteDatasource {
  final String baseUrl = 'http://10.0.2.2:8000/';
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  ///Method to get all the categories from the database
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      // final response = await dio.get('categories');
      final response = await dio.get('categories');
      final List<dynamic> decodedJson = response.data;

      if (response.statusCode == 200) {
        final categories = decodedJson
            .map((item) => CategoryEntity.fromMap(item).toModel())
            .toList();
        return Right(categories);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  /// MEthod to get all the transactions
  Future<Either<Failure, List<TransactionModel>>> getAllTransactions() async {
    try {
      final response = await dio.get('transactions');
      final List<dynamic> decodedJson = response.data;

      if (response.statusCode == 200) {
        final transactions = decodedJson
            .map((item) => TransactionEntity.fromMap(item).toModel())
            .toList(); //
        return Right(transactions);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
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

      final queryParams = <String, dynamic>{};

      if (limit != null) queryParams['limit'] = limit;
      if (skip != null) queryParams['skip'] = skip;
      if (categoryId != null) queryParams['category_id'] = categoryId;
      queryParams['date'] = date.toLowerCase();


      final response = await dio.get(
        'transactions',
        queryParameters: queryParams
      );

      final List<dynamic> decodedJson = response.data;


      if (response.statusCode == 200) {
        final transactions = decodedJson
            .map((item) => TransactionEntity.fromMap(item).toModel())
            .toList(); 
        return Right(transactions);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionModel newTransaction,
  ) async {
    try {
      final t = CreateTransactionDto(
        date: newTransaction.date,
        userId: 'testid',
        amount: newTransaction.amount,
        categoryId: newTransaction.category.id,
        type: newTransaction.type.name,
      );

      final response = await dio.post('transactions', data: t.toMap());
      final decodedJson = response.data;

      if (response.statusCode == 200) {
        final transaction = TransactionEntity.fromMap(decodedJson).toModel();
        return Right(transaction);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteTransaction(int transactionId) async {
    try {
      final response = await dio.delete('transactions/$transactionId');

      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }

  Future<Either<Failure, TransactionModel>> updateTransaction(
    int transactionId,
    TransactionModel transaction,
  ) async {
    try {
      final response = await dio.put(
        'transactions/$transactionId',
        data: CreateTransactionDto(
          date: transaction.date,
          userId: 'testid',
          amount: transaction.amount,
          categoryId: transaction.category.id,
          type: transaction.type.name,
        ).toMap(),
      );

      final decodedJson = response.data;

      if (response.statusCode == 200) {
        final transactionResponse = TransactionEntity.fromMap(
          decodedJson,
        ).toModel();
        return Right(transactionResponse);
      } else {
        return Left(DataSourceException(response.statusMessage.toString()));
      }
    } catch (error) {
      return Left(DataSourceException(error.toString()));
    }
  }
}
