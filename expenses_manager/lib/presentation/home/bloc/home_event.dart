part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadLastMovementsEvent extends HomeEvent {}

class SignOutEvent extends HomeEvent {}