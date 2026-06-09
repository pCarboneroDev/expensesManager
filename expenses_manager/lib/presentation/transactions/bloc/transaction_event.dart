part of 'transaction_bloc.dart';

abstract class TransactionEvent {}

class OnLoadMonthTransactions extends TransactionEvent {}

class DeleteTransaction extends TransactionEvent {
  final String transactionId;

  DeleteTransaction({required this.transactionId}); 
}

class FilterCategory extends TransactionEvent {
  final String id;
  FilterCategory({required this.id});
}

class FilterDateEvent extends TransactionEvent{
  final String date;

  FilterDateEvent({required this.date});
}