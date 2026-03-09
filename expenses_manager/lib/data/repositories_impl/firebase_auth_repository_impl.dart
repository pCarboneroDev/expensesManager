import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/firebase_auth_service.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthService service;

  FirebaseAuthRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(String email, String password) async {
    return await service.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password) async {
    return await service.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<Failure, bool>> signout() async {
    return await service.signOut();
  }
}