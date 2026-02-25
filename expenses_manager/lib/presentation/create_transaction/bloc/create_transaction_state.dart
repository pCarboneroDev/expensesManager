part of 'create_transaction_bloc.dart';

class CreateTransactionState extends Equatable {
  final UIState uiState;
  final TransactionModel newTransaction;

  final double quantity;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;

  final List<CategoryModel> categories;

  const CreateTransactionState({
    required this.uiState,
    required this.newTransaction,
    required this.quantity,
    required this.date,
    required this.category,
    required this.type,
    required this.categories
  });

  CreateTransactionState copyWith(
    {UIState? uiState,
    TransactionModel? newTransaction,

    double? quantity,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
    List<CategoryModel>? categories}
  ) => CreateTransactionState(
    uiState: uiState ?? this.uiState,
    newTransaction: newTransaction ?? this.newTransaction,
    quantity: quantity ?? this.quantity,
    date: date ?? this.date,
    category: category ?? this.category,
    type: type ?? this.type,
    categories: categories ?? this.categories
  );

  @override
  List<Object> get props => [uiState, newTransaction, quantity, date, category, type];
}
