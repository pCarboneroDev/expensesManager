import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_month_transactions_usecase.dart';
import 'package:expenses_manager/utils/ui_state.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetMonthTransactionsUsecase getMonthTransactionsUsecase;

  TransactionBloc(this.getMonthTransactionsUsecase)
    : super(TransactionState(uiState: UIState.idle(), transactionList: [])) {
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnLoadMonthTransactions>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));
      final result = await getMonthTransactionsUsecase.call(null); //todo ver si es mejor quitar null
      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (transactions) => emit(
          state.copyWith(
            uiState: UIState.success(),
            transactionList: transactions,
          ),
        ),
      );
    });

  }
}
