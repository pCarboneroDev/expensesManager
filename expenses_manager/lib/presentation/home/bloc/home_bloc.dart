import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_last_transactions_usecase.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLastTransactionsUsecase getLastMovementsUsecase;

  HomeBloc(this.getLastMovementsUsecase)
    : super(
        HomeState(
          uiState: UIState.idle(),
          monthIncome: 1000,
          monthExpenses: 500,
          lastMovements: [],
        ),
      ) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadLastMovementsEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));
      final result = await getLastMovementsUsecase.call(null); // todo ver si es mejor quitar null

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (movements) {
          final income = movements
              .where((e) => (e.type == TransactionType.income /*&& e.date.month == DateTime.now().month*/))
              .fold(0.0, (sum, e) => sum += e.quantity);

          final expense = movements
              .where((e) => e.type == TransactionType.expense)
              .fold(0.0, (sum, e) => sum += e.quantity);

          emit(
            state.copyWith(
              uiState: UIState.success(),
              lastMovements: movements,
              monthExpenses: expense,
              monthIncome: income,
            ),
          );
        },
      );
    });
  }
}
