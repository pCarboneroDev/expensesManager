import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_last_transactions_usecase.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:expenses_manager/utils/ui_state.dart';

part 'insights_event.dart';
part 'insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetLastTransactionsUsecase getLastTransactionsUsecase;

  InsightsBloc(this.getCategoriesUsecase, this.getLastTransactionsUsecase)
    : super(
        InsightsState(
          categories: [],
          uiState: UIState.idle(),
          lastTransactions: [],
          categoryMap: {},
          finalExpense: 0,
          finalIncome: 0
        ),
      ) {
    on<InsightsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadCategoriesEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));
      final categoriesFuture = getCategoriesUsecase.call(null);
      final lastFuture = getLastTransactionsUsecase.call(null);

      final results = await Future.wait([categoriesFuture, lastFuture]);

      final Either<Failure, List<TransactionModel>> transactions =
          results[1] as Either<Failure, List<TransactionModel>>;
      final Either<Failure, List<CategoryModel>> categories =
          results[0] as Either<Failure, List<CategoryModel>>;

      categories.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) => emit(state.copyWith(categories: r)),
      );

      transactions.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) {
          double income = 0;
          double expense = 0;
          Map<String, double> categoryMap = {};

          for (var t in r) {
            if (t.type == TransactionType.expense) {
              expense += t.amount;
              categoryMap[t.category.name] =
                  (categoryMap[t.category.name] ?? 0) + t.amount;
            } else {
              income += t.amount;
            }
          }
          emit(state.copyWith(lastTransactions: r, finalExpense: expense, finalIncome: income, categoryMap: categoryMap, uiState: UIState.success()));
        },
      );
    });
  }
}