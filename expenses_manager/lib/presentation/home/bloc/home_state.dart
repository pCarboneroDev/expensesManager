part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UIState uiState;
  final double monthIncome;
  final double monthExpenses;
  final List<TransactionModel> lastMovements;
  final bool user;

  const HomeState({
    required this.uiState,
    required this.monthIncome,
    required this.monthExpenses,
    required this.lastMovements,
    required this.user
  });

  HomeState copyWith({
    UIState? uiState,
    double? monthIncome,
    double? monthExpenses,
    List<TransactionModel>? lastMovements,
    bool? user,
  }) => HomeState(
    uiState: uiState ?? this.uiState,
    monthIncome: monthIncome ?? this.monthIncome,
    monthExpenses: monthExpenses ?? this.monthExpenses,
    lastMovements: lastMovements ?? this.lastMovements,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [monthIncome, monthExpenses, lastMovements, user];
}
