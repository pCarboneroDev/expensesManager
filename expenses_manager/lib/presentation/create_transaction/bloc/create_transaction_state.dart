part of 'create_transaction_bloc.dart';

class CreateTransactionState extends Equatable {
  final UIState uiState;
  final TransactionModel newTransaction;

  final double amount;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;

  final List<CategoryModel> categories;

  const CreateTransactionState({
    required this.uiState,
    required this.newTransaction,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.categories,
  });

  CreateTransactionState copyWith({
    UIState? uiState,
    TransactionModel? newTransaction,

    double? amount,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
    List<CategoryModel>? categories,
  }) => CreateTransactionState(
    uiState: uiState ?? this.uiState,
    newTransaction: newTransaction ?? this.newTransaction,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    category: category ?? this.category,
    type: type ?? this.type,
    categories: categories ?? this.categories,
  );

  CreateTransactionState initial() => CreateTransactionState(
    uiState: UIState.idle(),
    newTransaction: TransactionModel.empty(),
    amount: 0,
    date: DateTime.now(),
    category: CategoryModel(id: 0, name: "", icon: Icons.restaurant),
    type: TransactionType.expense,
    categories: [],
  );

  @override
  List<Object> get props => [
    uiState,
    newTransaction,
    amount,
    date,
    category,
    type,
  ];
}
