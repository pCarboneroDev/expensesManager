import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';

abstract class TransactionsRepository {
  Future<Either<Failure, List<TransactionModel>>> getLastTransactions();
  Future<Either<Failure, List<TransactionModel>>> getMonthTransactions();
} 