import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/models/params/user_params.dart';
import 'package:expenses_manager/domain/usecases/auth/login_usecase.dart';
import 'package:expenses_manager/domain/usecases/auth/register_usecase.dart';
import 'package:expenses_manager/domain/usecases/auth/signout_usecase.dart';
import 'package:expenses_manager/domain/usecases/users/create_user_usecase.dart';
import 'package:expenses_manager/utils/ui_state.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final SingOutUsecase singOutUsecase;
  final CreateUserUsecase createUserUsecase;

  LoginBloc(
    this.registerUsecase,
    this.loginUsecase,
    this.singOutUsecase,
    this.createUserUsecase,
  ) : super(LoginState(uistate: UIState.idle())) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<Register>((event, emit) async {
      // bool registered = false;

      emit(state.copyWith(uistate: UIState.loading()));

      final result = await registerUsecase.call(
        UserParams(email: event.email, password: event.password),
      );

      result.fold(
        (fail) => emit(state.copyWith(uistate: UIState.error(fail.message))),
        (user) => emit(state.copyWith(uistate: UIState.success())),
      );
    });

    on<Login>((event, emit) async {
      emit(state.copyWith(uistate: UIState.loading()));

      final result = await loginUsecase.call(
        UserParams(email: event.email, password: event.password),
      );

      result.fold(
        (fail) => emit(state.copyWith(uistate: UIState.error(fail.message))),
        (user) => emit(state.copyWith(uistate: UIState.success())),
      );
    });
  }
}
