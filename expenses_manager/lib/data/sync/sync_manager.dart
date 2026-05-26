import 'dart:async';

import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/task_entity.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/utils/operation_type.dart';
import 'package:expenses_manager/utils/sync_status.dart';

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
        //todo comprobar conexión a internet y gestionar fails
        await syncTasks();
      }
    });
  }

  Future<void> syncTasks() async {
    final result = await source.getPendingTasks();

    result.fold((l) => {print("No se algún error owo")}, (r) async {
      for (final task in r) {
        await uploadTask(task);
      }
    });
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
        // Manejar error de forma más específica
        print("Error obteniendo transacción local: $failure");
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

  void dispose() {
    _subscription?.cancel();
  }
}
