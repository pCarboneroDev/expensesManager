part of 'create_transaction_bloc.dart';

abstract class CreateTransactionEvent {}

class LoadCategories extends CreateTransactionEvent {}

class CreateTransction extends CreateTransactionEvent{
  final TransactionModel newTransaction;
  CreateTransction(this.newTransaction);
}

class UpdateTransactionType extends CreateTransactionEvent {
  final TransactionType type;
  UpdateTransactionType(this.type);
}

class UpdateTransactionQuantity extends CreateTransactionEvent {
  final double quantity;
  UpdateTransactionQuantity(this.quantity);
}

class UpdateTransactionDate extends CreateTransactionEvent {
  final DateTime date;
  UpdateTransactionDate(this.date);
}

class UpdateTransactionCategory extends CreateTransactionEvent {
  final CategoryModel category;
  UpdateTransactionCategory(this.category);
}