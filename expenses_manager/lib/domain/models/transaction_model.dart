import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionModel{
  final String id;
  final DateTime date;
  final double amount;
  final CategoryModel category;
  final TransactionType type;

  const TransactionModel({required this.id, required this.date, required this.amount, required this.category, required this.type});

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date.toString(),
    "amount": amount,
    "id_category": category.id,
    "transaction_type": type.name,
  };

  factory TransactionModel.empty() {
    return TransactionModel(
      id: "",
      date: DateTime.now(),
      amount: 0,
      category: CategoryModel(id: "", name: "", icon: Icons.restaurant),
      type: TransactionType.expense
    );
  }
}