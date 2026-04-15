import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/mock_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository{
  final MockDatasource dataSource;
  final RemoteDatasource remoteDatasource;

  const TransactionsRepositoryImpl(this.dataSource, this.remoteDatasource);

  @override
  Future<Either<Failure, List<TransactionModel>>> getLastTransactions() async {
    return await remoteDatasource.getLastTransactions();
  }
  
  @override
  Future<Either<Failure, List<TransactionModel>>> getMonthTransactions() async {
    return await remoteDatasource.getAllTransactions();
  }
  
  @override
  Future<Either<Failure, TransactionModel>> createTransaction(TransactionModel transaction) async {
    return await remoteDatasource.createTransaction(transaction);
  }
  
  @override
  Future<Either<Failure, bool>> deleteTransaction(int transactionId) async {
    return await remoteDatasource.deleteTransaction(transactionId);
  }
  
  @override
  Future<Either<Failure, TransactionModel>> updateTransaction(int transactionId, TransactionModel transaction) {
    return remoteDatasource.updateTransaction(transactionId, transaction);
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions(FilterTransactionsParams params) {
    return remoteDatasource.getFilteredTransactions(skip: params.skip, limit: params.limit, categoryId: params.categoryId, date: params.date);
  }
}