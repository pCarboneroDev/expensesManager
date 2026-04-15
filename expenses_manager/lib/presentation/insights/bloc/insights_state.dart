part of 'insights_bloc.dart';

class InsightsState extends Equatable {
  final UIState uiState;
  final List<CategoryModel> categories;
  final List<TransactionModel> lastTransactions;
  final Map<String, double> categoryMap;
  final double finalIncome;
  final double finalExpense;

  const InsightsState({
    required this.uiState, 
    required this.categories, 
    required this.lastTransactions, 
    required this.categoryMap,
    required this.finalExpense,
    required this.finalIncome
  });

  InsightsState copyWith({
    UIState? uiState,
    List<CategoryModel>? categories,
    List<TransactionModel>? lastTransactions,
    Map<String, double>? categoryMap,
    double? finalIncome,
    double? finalExpense
  }) => InsightsState(
          categories: categories ?? this.categories, 
          uiState: uiState ?? this.uiState,
          lastTransactions: lastTransactions ?? this.lastTransactions,
          categoryMap: categoryMap ?? this.categoryMap,
          finalExpense: finalExpense ?? this.finalExpense,
          finalIncome: finalIncome ?? this.finalIncome
        );

  @override
  List<Object> get props => [categories, uiState, lastTransactions, categoryMap, finalIncome, finalExpense];
}
