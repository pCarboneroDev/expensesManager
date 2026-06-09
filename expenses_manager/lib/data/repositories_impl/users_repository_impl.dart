import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/user_entity.dart';
import 'package:expenses_manager/data/sync/sync_notifier.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository{
  final RemoteDatasource remoteDatasource;
  final SyncNotifier notifier;

  UsersRepositoryImpl({required this.remoteDatasource, required this.notifier});
  @override
  Future<Either<Failure, UserEntity>> createUser(user) async {
    final result = await remoteDatasource.createUser(user);

    //todo esto debería ir en firebse repo 
    result.fold(
      (l) => null,
      (r) => notifier.notifyTableChanged("transactions"),
    );

    return result;
  }

}