part of 'login_bloc.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class Register extends LoginEvent {
  final String email;
  final String password;

  Register({required this.email, required this.password});
}

class SignOut extends LoginEvent{}