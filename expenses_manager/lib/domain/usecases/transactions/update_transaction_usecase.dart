import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/update_params.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class UpdateTransactionUsecase implements UseCase<UpdateParams, TransactionModel> {
  final TransactionsRepository repo;

  UpdateTransactionUsecase(this.repo);

  @override
  Future<Either<Failure, TransactionModel>> call(UpdateParams params) {
    return repo.updateTransaction(params.transactionId, params.transaction);
  } 
}