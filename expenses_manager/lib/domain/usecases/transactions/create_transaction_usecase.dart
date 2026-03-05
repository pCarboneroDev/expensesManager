import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class CreateTransactionUsecase implements UseCase<TransactionModel, TransactionModel> {
  final TransactionsRepository repo;

  CreateTransactionUsecase(this.repo);

  @override
  Future<Either<Failure, TransactionModel>> call(TransactionModel params) {
    return repo.createTransaction(params);
  }
}