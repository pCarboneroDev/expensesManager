import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/prediction/predict_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_filtered_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_last_transactions_usecase.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:expenses_manager/utils/ui_state.dart';

part 'insights_event.dart';
part 'insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  String _getMonth(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid month number";
    }
  }

  String _getDay(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Invalid day number";
    }
  }

  final GetCategoriesUsecase getCategoriesUsecase;
  final GetLastTransactionsUsecase getLastTransactionsUsecase;
  final GetFilteredTransactionsUsecase getFilteredTransactionsUsecase;
  final PredictUsecase predictUsecase;


  InsightsBloc(
    this.getCategoriesUsecase,
    this.getLastTransactionsUsecase,
    this.getFilteredTransactionsUsecase,
    this.predictUsecase
  ) : super(
        InsightsState(
          categories: [],
          uiState: UIState.idle(),
          lastTransactions: [],
          categoryMap: {},
          finalExpense: 0,
          finalIncome: 0,
          expensesMonth: {},
          expensesDay: {},
          prediction: 0,
          predictionLoading: false
        ),
      ) {
    on<InsightsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadMainInsight>((event, emit) async {
      emit(
        state.copyWith(
          uiState: UIState.loading(),
          expensesMonth: state.initialExpensesMonth(),
          expensesDay: state.initialExpensesDay(),
          predictionLoading: true
        ),
      );
      Map<String, double> map = state.expensesMonth;
      Map<String, double> mapDay = state.expensesDay;

      final result = await getFilteredTransactionsUsecase.callRaw(
        FilterTransactionsParams(date: 'year'),
      );

      result.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (transactions) {
          final now = DateTime.now();
          final currentWeekStart = now.subtract(
            Duration(days: now.weekday - 1),
          );
          final currentWeekEnd = currentWeekStart.add(const Duration(days: 6));

          final weekTransactions = transactions.where((t) {
            return t.date.isAfter(
                  currentWeekStart.subtract(const Duration(days: 1)),
                ) &&
                t.date.isBefore(currentWeekEnd.add(const Duration(days: 1)));
          }).toList();

          for (var t in transactions) {
            if (t.type == TransactionType.expense) {
              var month = _getMonth(t.date.month);
              if (map[month] != null) {
                map[month] = map[month]! + t.amount;
              }
            }
          }

          for (var t in weekTransactions) {
            if (t.type == TransactionType.expense) {
              var day = _getDay(t.date.weekday);
              if (mapDay[day] != null) {
                mapDay[day] = mapDay[day]! + t.amount;
              }
            }
          }
          emit(state.copyWith(expensesMonth: map, uiState: UIState.success(), expensesDay: mapDay));
        },
      );


      final predictionResult = await predictUsecase.call(null);

      predictionResult.fold(
        (l) => emit(state.copyWith(uiState: UIState.error(l.message))),
        (r) => emit(state.copyWith(predictionLoading: false, prediction: r)),
      );
    });

    on<LoadCategoriesEvent>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));
      final categoriesFuture = getCategoriesUsecase.call(null);
      final lastFuture = getFilteredTransactionsUsecase.callRaw(FilterTransactionsParams(date: 'month'));

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

          for (var i = 0; i < 12; i++) {}
          emit(
            state.copyWith(
              lastTransactions: r,
              finalExpense: expense,
              finalIncome: income,
              categoryMap: categoryMap,
              uiState: UIState.success(),
            ),
          );
        },
      );
    });
  }
}
