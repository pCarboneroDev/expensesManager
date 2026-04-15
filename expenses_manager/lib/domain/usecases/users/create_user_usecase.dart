import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/entities/user_entity.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/users_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class CreateUserUsecase implements UseCase<UserEntity, UserEntity> {
  final UsersRepository repo;

  CreateUserUsecase(this.repo);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) {
    return repo.createUser(params);
  }
}