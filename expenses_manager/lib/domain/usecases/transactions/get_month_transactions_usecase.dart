import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';
import 'package:expenses_manager/utils/group_by_day.dart';

class GetMonthTransactionsUsecase implements UseCase<void, Map<DateTime, List<TransactionModel>>>{
  final TransactionsRepository repo;

  const GetMonthTransactionsUsecase(this.repo);

  @override
  Future<Either<Failure, Map<DateTime, List<TransactionModel>>>> call(void params) {
    return repo.getMonthTransactions().then(
      (either) => either.fold(
        (failure) => Left(failure),
        (transactions) => Right(groupTransactionsByDay(transactions)),
      ),
    );
  }
}