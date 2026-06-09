import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/firebase_auth_service.dart';
import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/user_entity.dart';
import 'package:expenses_manager/data/sync/sync_manager.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthService service;
  final RemoteDatasource datasource;
  final LocalDatasource localDatasource;
  final SyncNotifier notifier;
  final SyncManager manager;

  FirebaseAuthRepositoryImpl({required this.service, required this.datasource, required this.localDatasource, required this.notifier, required this.manager});

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(String email, String password) async {
    final userResult = await service.loginWithEmailAndPassword(email, password);

    if(userResult.isRight()){
      notifier.notifyTableChanged('tasks');
      // llamar al sync manager y meter todo en local
      manager.syncLocal();
    } 
    
    return userResult;
  }

  @override  
  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password) async {
    final user = await service.registerWithEmailAndPassword(email, password);

    user.fold(
      (fail) => fail,
      (right) async {
        datasource.createUser(UserEntity(id: right.uid, email: right.email!));
        notifier.notifyTableChanged('tasks');    
        return right;
      }
    );

    return user;
  }

//   @override
// Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password) async {
//   final userResult = await service.registerWithEmailAndPassword(email, password);
  
//   return userResult.fold(
//     (failure) => Left(failure),
//     (user) async {
//       try {
//         // Create user in local database
//         await datasource.createUser(UserEntity(id: user.uid, email: user.email!));
        
//         // Sync all transactions
//         final syncResult = await localDatasource.syncAllTransactions();
        
//         syncResult.fold(
//           (failure) {
//             // Log sync failure but don't fail the registration
//             print('Failed to sync transactions: $failure');
//           },
//           (_) => notifier.notifyTableChanged("tasks"),
//         );
        
//         return Right(user);
//       } catch (e) {
//         // Handle any exceptions during post-registration setup
//         print('Post-registration setup failed: $e');
//         return Left(DataSourceException('Failed to complete registration setup: $e'));
//       }
//     },
//   );
// }

  @override
  Future<Either<Failure, bool>> signout() async {
    return await service.signOut();
  }
}