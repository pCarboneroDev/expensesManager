import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/data/entities/user_entity.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository{
  final RemoteDatasource remoteDatasource;

  UsersRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, UserEntity>> createUser(user) async {
    return await remoteDatasource.createUser(user);
  }

}