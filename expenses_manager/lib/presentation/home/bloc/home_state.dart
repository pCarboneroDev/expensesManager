part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UIState uiState;
  final double monthIncome;
  final double monthExpenses;
  final List<TransactionModel> lastMovements;

  const HomeState({
    required this.uiState,
    required this.monthIncome,
    required this.monthExpenses,
    required this.lastMovements,
  });

  HomeState copyWith({
    UIState? uiState,
    double? monthIncome,
    double? monthExpenses,
    List<TransactionModel>? lastMovements,
  }) => HomeState(
    uiState: uiState ?? this.uiState,
    monthIncome: monthIncome ?? this.monthIncome,
    monthExpenses: monthExpenses ?? this.monthExpenses,
    lastMovements: lastMovements ?? this.lastMovements,
  );

  @override
  List<Object?> get props => [monthIncome, monthExpenses, lastMovements];
}
