import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/entities/user_entity.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';

abstract class UsersRepository {
  Future<Either<Failure, UserEntity>> createUser(UserEntity user);
}