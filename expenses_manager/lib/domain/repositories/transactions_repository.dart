import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';

abstract class TransactionsRepository {
  Future<Either<Failure, List<TransactionModel>>> getLastTransactions();
  Future<Either<Failure, List<TransactionModel>>> getMonthTransactions();
  Future<Either<Failure, TransactionModel>> createTransaction(TransactionModel transaction);
  Future<Either<Failure, bool>> deleteTransaction(int transactionId);
  Future<Either<Failure, TransactionModel>> updateTransaction(int transactionId, TransactionModel transaction);
  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions(FilterTransactionsParams params);
} 