import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class DeleteTransactionUsecase implements UseCase<String, bool> {
  final TransactionsRepository repo;

  DeleteTransactionUsecase(this.repo);

  @override
  Future<Either<Failure, bool>> call(String params) {
    return repo.deleteTransaction(params);
  }

}