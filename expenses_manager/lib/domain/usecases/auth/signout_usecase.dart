import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/firebase_auth_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class SingOutUsecase implements UseCase<void, bool> {
  final FirebaseAuthRepository repo;

  SingOutUsecase(this.repo);
  
  @override
  Future<Either<Failure, bool>> call(void params) {
    return repo.signout();
  } 
}