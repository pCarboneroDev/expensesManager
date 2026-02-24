part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final UIState uiState;
  final List<TransactionModel> transactionList;

  const TransactionState({
    required this.uiState,
    required this.transactionList,
  });

  TransactionState copyWith({
    UIState? uiState,
    List<TransactionModel>? transactionList,
  }) => TransactionState(
    uiState: uiState ?? this.uiState,
    transactionList: transactionList ?? this.transactionList,
  );

  @override
  List<Object> get props => [uiState, transactionList];
}
