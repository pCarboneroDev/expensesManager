import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/task_entity.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/transaction_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/utils/operation_type.dart';
import 'package:expenses_manager/utils/sync_status.dart';

class TransactionsRepositoryImpl implements TransactionsRepository{
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;
  final SyncNotifier syncNotifier;

  TransactionsRepositoryImpl(this.remoteDatasource, this.localDatasource, this.syncNotifier);

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
    // return await remoteDatasource.createTransaction(transaction);
    // final User? user = FirebaseAuth.instance.currentUser;

    final result = await localDatasource.createTransaction(transaction);

    if(result.isRight()) {
      await localDatasource.createTask(
        TaskEntity( 
          entityType: "transaction",
          entityId: result.fold(
            (l) => "",
            (r) => r.id,
          ), 
          operation: OperationType.create,
          createdAt: DateTime.now(), 
          attempts: 0, 
          status: SyncStatus.pending
        )
      );
      syncNotifier.notifyTableChanged('tasks');
    }
    return result;
  }
  
  @override
  Future<Either<Failure, bool>> deleteTransaction(String transactionId) async {
    // final User? user = FirebaseAuth.instance.currentUser;

    final result = await localDatasource.deleteTransaction(transactionId);

    if(result.isRight()) {
      await localDatasource.createTask(
        TaskEntity( 
          entityType: "transaction",
          entityId: transactionId,
          operation: OperationType.delete,
          createdAt: DateTime.now(), 
          attempts: 0, 
          status: SyncStatus.pending
        )
      );
      syncNotifier.notifyTableChanged('tasks');
    }

    return result;
    // return await remoteDatasource.deleteTransaction(transactionId);
  }
  
  @override
  Future<Either<Failure, TransactionModel>> updateTransaction(String transactionId, TransactionModel transaction) async {
    // final User? user = FirebaseAuth.instance.currentUser;

    final result = await localDatasource.updateTransaction(transactionId, transaction);

    if(result.isRight()) {
      await localDatasource.createTask(
        TaskEntity( 
          entityType: "transaction",
          entityId: transactionId,
          operation: OperationType.update,
          createdAt: DateTime.now(), 
          attempts: 0, 
          status: SyncStatus.pending
        )
      );
      syncNotifier.notifyTableChanged('tasks');
    }

    return result;
    // return remoteDatasource.updateTransaction(transactionId, transaction);
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions(FilterTransactionsParams params) {
    // return remoteDatasource.getFilteredTransactions(skip: params.skip, limit: params.limit, categoryId: params.categoryId, date: params.date);
    return localDatasource.getFilteredTransactions(skip: params.skip, limit: params.limit, categoryId: params.categoryId, date: params.date);
  }
}