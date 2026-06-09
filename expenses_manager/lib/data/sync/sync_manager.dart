import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/task_entity.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/utils/operation_type.dart';
import 'package:expenses_manager/utils/sync_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SyncManager {
  final SyncNotifier notifier;
  // final TaskRepository repository;
  final LocalDatasource source;
  final RemoteDatasource remote;
  StreamSubscription? _subscription;

  SyncManager({
    required this.notifier,
    required this.source,
    required this.remote,
    // required this.repository,
  });

  void start() {
    _subscription = notifier.stream.listen((table) async {
      if (table == 'tasks') {
        //todo gestionar fails
        

        final internet = await hasInternetAccess();
        final user = FirebaseAuth.instance.currentUser;

        if (internet && user != null) {
          await syncTasks();
        }
      }
    });
  }

  Future<void> syncTasks() async {
    final result = await source.getPendingTasks();

    result.fold(
      (l) => {
        print("No se algún error owo")}, 
      (r) async {
        for (final task in r) {
          await uploadTask(task);
        }
      }
    );
  }

  Future<Either<Failure, bool>> syncLocal() async {
    try{
      final remoteResult = await remote.getFilteredTransactions(date: 'all');
    
      remoteResult.fold(
        (l) => throw DataSourceException("message"),
        (r) {
          source.insertTransactionList(r);
        },
      );
      return Right(true);
    }
    catch(e){
      return Left(DataSourceException("message"));
    }
  }

  // Future<void> uploadTask(TaskEntity task) async {
  //   // API call
  //   final Either<Failure, TransactionModel> localResponse;
  //   Either<Failure, dynamic> res;

  //   if (task.operation == OperationType.delete) {
  //     res = await remote.deleteTransaction(task.entityId);
  //     source.setTaskStatus(SyncStatus.synced, task.entityId);
  //   } else {
  //     localResponse = await source.getTransactionId(task.entityId);

  //     localResponse.fold(
  //       (l) => print("ERROR"),
  //       (r) async {
  //       res = switch (task.operation) {
  //         OperationType.create => await remote.createTransaction(r),
  //         OperationType.update => await remote.updateTransaction(r.id, r),
  //         OperationType.delete => await remote.deleteTransaction(task.entityId),
  //       };

  //       res.fold(
  //         (l) => source.setTaskStatus(SyncStatus.failed, task.entityId),
  //         (r) => source.setTaskStatus(SyncStatus.synced, task.entityId),
  //       );
  //     });
  //   }
  // }

  Future<void> uploadTask(TaskEntity task) async {
    // Manejo de eliminación (no necesita obtener datos locales)
    if (task.operation == OperationType.delete) {
      final result = await remote.deleteTransaction(task.entityId);
      final status = result.isRight() ? SyncStatus.synced : SyncStatus.failed;
      source.setTaskStatus(status, task.entityId);
      return;
    }

    // Para create/update, obtener transacción local
    final localResponse = await source.getTransactionId(task.entityId);

    await localResponse.fold(
      (failure) async {
        source.setTaskStatus(SyncStatus.failed, task.entityId);
      },
      (transaction) async {
        // Ejecutar operación remota
        final result = switch (task.operation) {
          OperationType.create => await remote.createTransaction(transaction),
          OperationType.update => await remote.updateTransaction(
            transaction.id,
            transaction,
          ),
          _ => throw UnsupportedError(
            'Operación no soportada: ${task.operation}',
          ),
        };

        // Actualizar estado según resultado
        final status = result.isRight() ? SyncStatus.synced : SyncStatus.failed;
        source.setTaskStatus(status, task.entityId);
      },
    );
  }

  Future<bool> hasInternetAccess() async {
    // 1. Verificar si hay una red disponible (WiFi, datos, etc.)
    final connectivityResult = await Connectivity().checkConnectivity();
    
    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No está conectado a ninguna red
      return false;
    }

    // 2. Hay una red, ahora comprobamos si tiene acceso real a internet
    //    internet_connection_checker suele ser más fiable que hacer un simple GET.
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }

  void dispose() {
    _subscription?.cancel();
  }
}
