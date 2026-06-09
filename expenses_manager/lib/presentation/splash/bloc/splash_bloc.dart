import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/entities/task_entity.dart';
import 'package:expenses_manager/data/sync/sync_manager.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/utils/sync_status.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SyncManager syncManager;
  final SyncNotifier syncNotifier;
  final LocalDatasource localDatasource;

  SplashBloc(this.syncManager, this.syncNotifier, this.localDatasource) : super(SplashState(uiState: UIState.loading())) {
    on<SplashEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SyncDataEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));

      if (FirebaseAuth.instance.currentUser == null) {
        emit(state.copyWith(uiState: UIState.success()));
        return;
      }
      
      final res = await syncManager.syncLocal();

      res.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) => emit(state.copyWith(uiState: UIState.success())),
      );
    });

    on<ManageFailsEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));
      final tasks = await localDatasource.getFailedTasks();

      tasks.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) async {
          for (final task in r) {
            localDatasource.setTaskStatus(SyncStatus.pending, task.entityId);
          }
          syncNotifier.notifyTableChanged('tasks');
          emit(state.copyWith(uiState: UIState.success()));
        }
      );
    });

    on<SyncEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));

      if (FirebaseAuth.instance.currentUser == null) {
        emit(state.copyWith(uiState: UIState.success()));
        return;
      }

      final syncLocalFuture = syncManager.syncLocal();
      final failedTasksFuture = localDatasource.getFailedTasks();

      final results = await Future.wait([syncLocalFuture, failedTasksFuture]);

      final syncResult = results[0] as Either<Failure, bool>;
      final failedTasksResult = results[1] as Either<Failure, List<TaskEntity>>;

      syncResult.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) {
          failedTasksResult.fold(
            (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
            (r) async {
              for (final task in r) {
                localDatasource.setTaskStatus(SyncStatus.pending, task.entityId);
              }
              syncNotifier.notifyTableChanged('tasks');
              emit(state.copyWith(uiState: UIState.success()));
            }
          );
        }
      );
      emit(state.copyWith(uiState: UIState.success()));
    });
  }
}
