import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null){
        return Right(user);
      }
      return Left(DataSourceException('unknown error'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Ya existe una cuenta con ese correo electrónico');
      }
      return Left(DataSourceException(e.toString()));
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  Future<Either<Failure, User>> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null){
        return Right(user);
      }
      return Left(DataSourceException('unknown error'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return Left(DataSourceException('Wrong password or email'));
      }
      return Left(DataSourceException(e.toString()));
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  Future<Either<Failure, bool>> signOut() async {
    try {
      await _auth.signOut();
      return Right(true);
    } catch (e) {
      print('Error al cerrar sesión: $e');
      return Left(DataSourceException(e.toString()));
    }
  }
}