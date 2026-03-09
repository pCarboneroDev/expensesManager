import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/repositories_impl/firebase_auth_repository_impl.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/params/user_params.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecase implements UseCase<UserParams, User> {
  final FirebaseAuthRepositoryImpl repo;

  LoginUsecase(this.repo);

  @override
  Future<Either<Failure, User>> call(UserParams params) {
    return repo.loginWithEmailAndPassword(params.email, params.password);
  }
}