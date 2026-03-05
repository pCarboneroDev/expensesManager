import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionModel{
  final int id;
  final DateTime date;
  final double amount;
  final CategoryModel category;
  final TransactionType type;

  const TransactionModel({required this.id, required this.date, required this.amount, required this.category, required this.type});

  factory TransactionModel.empty() {
    return TransactionModel(
      id: 0,
      date: DateTime.now(),
      amount: 0,
      category: CategoryModel(id: 0, name: "", icon: Icons.restaurant),
      type: TransactionType.expense
    );
  }
}