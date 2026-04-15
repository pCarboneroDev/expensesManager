import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';
import 'package:expenses_manager/utils/group_by_day.dart';

class GetFilteredTransactionsUsecase implements UseCase<FilterTransactionsParams, Map<DateTime, List<TransactionModel>>> {
  final TransactionsRepository repo;

  GetFilteredTransactionsUsecase(this.repo);
  @override
  Future<Either<Failure, Map<DateTime, List<TransactionModel>>>> call(FilterTransactionsParams params) {
    return repo.getFilteredTransactions(params).then(
      (either) => either.fold(
        (failure) => Left(failure),
        (transactions) => Right(groupTransactionsByDay(transactions)),
      ),
    );
  }

  Future<Either<Failure, List<TransactionModel>>> callRaw(FilterTransactionsParams params) {
    return repo.getFilteredTransactions(params);
  }
}