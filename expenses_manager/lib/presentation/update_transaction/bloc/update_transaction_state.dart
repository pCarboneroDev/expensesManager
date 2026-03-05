part of 'update_transaction_bloc.dart';

class UpdateTransactionState extends Equatable {
  final UIState uiState;
  final TransactionModel newTransaction;

  final double amount;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;
  final int transactionId;

  final List<CategoryModel> categories;

  const UpdateTransactionState({
    required this.uiState,
    required this.newTransaction,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.categories,
    required this.transactionId
  });

  UpdateTransactionState copyWith(
    {UIState? uiState,
    TransactionModel? newTransaction,

    double? amount,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
    List<CategoryModel>? categories,
    int? transactionId
    }
  ) => UpdateTransactionState(
    uiState: uiState ?? this.uiState,
    newTransaction: newTransaction ?? this.newTransaction,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    category: category ?? this.category,
    type: type ?? this.type,
    categories: categories ?? this.categories,
    transactionId: transactionId ?? this.transactionId
  );

  @override
  List<Object> get props => [uiState, newTransaction, amount, date, category, type, transactionId];
}
