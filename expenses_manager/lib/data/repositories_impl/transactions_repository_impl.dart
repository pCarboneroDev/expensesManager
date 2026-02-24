import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/mock_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository{
  final MockDatasource dataSource;

  const TransactionsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<TransactionModel>>> getLastTransactions() async {
    return await dataSource.getAllMovements();
  }
  
  @override
  Future<Either<Failure, List<TransactionModel>>> getMonthTransactions() async {
    return await dataSource.getAllMovements();
  }
}