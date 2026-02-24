import 'package:expenses_manager/domain/models/category_model.dart';

enum TransactionType {expense, income}

class TransactionModel{
  final int id;
  final DateTime date;
  final double quantity;
  final CategoryModel category;
  final TransactionType type;

  const TransactionModel({required this.id, required this.date, required this.quantity, required this.category, required this.type});
}