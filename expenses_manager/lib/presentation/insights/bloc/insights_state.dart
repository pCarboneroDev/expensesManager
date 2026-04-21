part of 'insights_bloc.dart';

class InsightsState extends Equatable {
  final UIState uiState;
  final List<CategoryModel> categories;
  final List<TransactionModel> lastTransactions;
  final Map<String, double> categoryMap;
  final double finalIncome;
  final double finalExpense;

  final Map<String, double> expensesMonth;
  final Map<String, double> expensesDay;

  const InsightsState({
    required this.uiState,
    required this.categories,
    required this.lastTransactions,
    required this.categoryMap,
    required this.finalExpense,
    required this.finalIncome,
    required this.expensesMonth,
    required this.expensesDay,
  });

  Map<String, double> initialExpensesMonth() {
    return {
      for (var month in [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ])
        month: 0.0,
    };
  }

  Map<String, double> initialExpensesDay() {
    return {
      for (var day in [
        'Monday',
        'Tuesday',
        'Wednesdey',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ])
        day: 0.0,
    };
  }

  InsightsState copyWith({
    UIState? uiState,
    List<CategoryModel>? categories,
    List<TransactionModel>? lastTransactions,
    Map<String, double>? categoryMap,
    double? finalIncome,
    double? finalExpense,
    Map<String, double>? expensesMonth,
    Map<String, double>? expensesDay
  }) => InsightsState(
    categories: categories ?? this.categories,
    uiState: uiState ?? this.uiState,
    lastTransactions: lastTransactions ?? this.lastTransactions,
    categoryMap: categoryMap ?? this.categoryMap,
    finalExpense: finalExpense ?? this.finalExpense,
    finalIncome: finalIncome ?? this.finalIncome,
    expensesMonth: expensesMonth ?? this.expensesMonth,
    expensesDay: expensesDay ?? this.expensesDay
  );

  @override
  List<Object> get props => [
    categories,
    uiState,
    lastTransactions,
    categoryMap,
    finalIncome,
    finalExpense,
    expensesMonth,
    expensesDay
  ];
}
