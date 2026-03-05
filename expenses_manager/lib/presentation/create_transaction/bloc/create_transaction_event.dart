part of 'create_transaction_bloc.dart';

abstract class CreateTransactionEvent {}

class LoadCategories extends CreateTransactionEvent {}

class CreateTransaction extends CreateTransactionEvent{
  final TransactionModel newTransaction;
  CreateTransaction(this.newTransaction);
}

class UpdateTransactionType extends CreateTransactionEvent {
  final TransactionType type;
  UpdateTransactionType(this.type);
}

class UpdateTransactionAmount extends CreateTransactionEvent {
  final double amount;
  UpdateTransactionAmount(this.amount);
}

class UpdateTransactionDate extends CreateTransactionEvent {
  final DateTime date;
  UpdateTransactionDate(this.date);
}

class UpdateTransactionCategory extends CreateTransactionEvent {
  final CategoryModel category;
  UpdateTransactionCategory(this.category);
}