part of 'update_transaction_bloc.dart';

abstract class UpdateTransactionEvent {}

class LoadCategories extends UpdateTransactionEvent {}

class UpdateTransactionType extends UpdateTransactionEvent {
  final TransactionType type;
  UpdateTransactionType(this.type);
}

class UpdateTransactionAmount extends UpdateTransactionEvent {
  final double quantity;
  UpdateTransactionAmount(this.quantity);
}

class UpdateTransactionDate extends UpdateTransactionEvent {
  final DateTime date;
  UpdateTransactionDate(this.date);
}

class UpdateTransactionCategory extends UpdateTransactionEvent {
  final CategoryModel category;
  UpdateTransactionCategory(this.category);
}

class UpdateTransaction extends UpdateTransactionEvent {
  final TransactionModel transaction;
  UpdateTransaction(this.transaction);
}

class UpdateTransactionId extends UpdateTransactionEvent {
  final int id;
  UpdateTransactionId(this.id);
}
