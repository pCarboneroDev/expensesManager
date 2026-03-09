import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, User>> loginWithEmailAndPassword(String email, String password);
  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password);
  Future<Either<Failure, bool>> signout();
}