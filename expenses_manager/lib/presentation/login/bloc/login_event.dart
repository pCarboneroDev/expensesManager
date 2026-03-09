part of 'login_bloc.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final String user;
  final String password;

  Login({required this.user, required this.password});
}

class Register extends LoginEvent {
  final String user;
  final String password;

  Register({required this.user, required this.password});
}

class SignOut extends LoginEvent{}