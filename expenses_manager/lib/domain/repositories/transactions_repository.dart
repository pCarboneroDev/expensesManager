import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/transaction_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';

abstract class TransactionsRepository {
  Future<Either<Failure, List<TransactionModel>>> getLastTransactions();
  Future<Either<Failure, List<TransactionModel>>> getMonthTransactions();
  Future<Either<Failure, TransactionModel>> createTransaction(TransactionModel transaction);
  Future<Either<Failure, bool>> deleteTransaction(String transactionId);
  Future<Either<Failure, TransactionModel>> updateTransaction(String transactionId, TransactionModel transaction);
  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions(FilterTransactionsParams params);
} 