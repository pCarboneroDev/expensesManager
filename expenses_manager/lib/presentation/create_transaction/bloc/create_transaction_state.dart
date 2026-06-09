part of 'create_transaction_bloc.dart';

class CreateTransactionState extends Equatable {
  final UIState uiState;
  final TransactionModel newTransaction;

  final double amount;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;

  final List<CategoryModel> categories;

  final OperationState operationState;

  const CreateTransactionState({
    required this.uiState,
    required this.newTransaction,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.categories,
    required this.operationState
  });



  CreateTransactionState copyWith({
    UIState? uiState,
    TransactionModel? newTransaction,

    double? amount,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
    List<CategoryModel>? categories,
    OperationState? operationState,
  }) => CreateTransactionState(
    uiState: uiState ?? this.uiState,
    newTransaction: newTransaction ?? this.newTransaction,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    category: category ?? this.category,
    type: type ?? this.type,
    categories: categories ?? this.categories,
    operationState: operationState ?? this.operationState,
  );

  CreateTransactionState initial() => CreateTransactionState(
    uiState: UIState.idle(),
    newTransaction: TransactionModel.empty(),
    amount: 0,
    date: DateTime.now(),
    category: CategoryModel(id: "", name: "", icon: Icons.restaurant),
    type: TransactionType.expense,
    categories: [],
    operationState: OperationState.idle
  );

  @override
  List<Object> get props => [
    uiState,
    newTransaction,
    amount,
    date,
    category,
    type,
    operationState
  ];
}
