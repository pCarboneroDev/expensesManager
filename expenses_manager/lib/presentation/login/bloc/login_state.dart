part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UIState uistate;

  const LoginState({required this.uistate});

  LoginState copyWith({
    UIState? uistate
  }) => LoginState(uistate: uistate ?? this.uistate);
  
  @override
  List<Object> get props => [uistate];
}
