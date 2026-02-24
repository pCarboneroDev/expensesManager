import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class GetMonthTransactionsUsecase implements UseCase<void, List<TransactionModel>>{
  final TransactionsRepository repo;

  const GetMonthTransactionsUsecase(this.repo);

  @override
  Future<Either<Failure, List<TransactionModel>>> call(void params) {
    return repo.getMonthTransactions();
  }
}