part of 'update_transaction_bloc.dart';

class UpdateTransactionState extends Equatable {
  final UIState uiState;
  final TransactionModel newTransaction;

  final double quantity;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;
  final int transactionId;

  final List<CategoryModel> categories;

  const UpdateTransactionState({
    required this.uiState,
    required this.newTransaction,
    required this.quantity,
    required this.date,
    required this.category,
    required this.type,
    required this.categories,
    required this.transactionId
  });

  UpdateTransactionState copyWith(
    {UIState? uiState,
    TransactionModel? newTransaction,

    double? quantity,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
    List<CategoryModel>? categories,
    int? transactionId
    }
  ) => UpdateTransactionState(
    uiState: uiState ?? this.uiState,
    newTransaction: newTransaction ?? this.newTransaction,
    quantity: quantity ?? this.quantity,
    date: date ?? this.date,
    category: category ?? this.category,
    type: type ?? this.type,
    categories: categories ?? this.categories,
    transactionId: transactionId ?? this.transactionId
  );

  @override
  List<Object> get props => [uiState, newTransaction, quantity, date, category, type, transactionId];
}
