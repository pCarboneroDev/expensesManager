import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/params/user_params.dart';
import 'package:expenses_manager/domain/repositories/firebase_auth_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUsecase implements UseCase<UserParams, User> {
  final FirebaseAuthRepository repo;

  RegisterUsecase(this.repo); 
  @override
  Future<Either<Failure, User>> call(UserParams params) {
    return repo.registerWithEmailAndPassword(params.email, params.password);
  }
}