import 'dart:convert';
import 'package:expenses_manager/data/entities/category_entity.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';

class TransactionEntity {
  final int id;
  final DateTime date;
  final String userId;
  final double amount;
  final CategoryEntity category;
  final TransactionType type;

  const TransactionEntity({required this.id, required this.date, required this.userId, required this.amount, required this.category, required this.type});

  String toJson() => json.encode(toMap());

  factory TransactionEntity.fromMap(Map<String, dynamic> json) => TransactionEntity(
    id: json["id"] ?? 0,
    date: DateTime.parse(json['date']),
    userId: json['user_id'],
    amount: json["amount"] ?? "",
    category: CategoryEntity.fromMap(json["category"]),
    type: TransactionType.fromString(json["transaction_type"])
  );

    Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "user_id": userId,
    "amount": amount,
    "id_category": category.id,
    "transaction_type": type.name
  };
}

extension TransactionEntityapper on TransactionEntity {
  TransactionModel toModel() {
    return TransactionModel(
      id: id, 
      date: date, 
      amount: amount, 
      category: category.toModel(), 
      type: type
    );
  }
}

// extension TransactionDtoMapper on TransactionEntity {
//   CreateTransactionDto toModel() {
//     return CreateTransactionDto(
//       date: date, 
//       amount: amount, 
//       categoryId: category.id, 
//       type: type.name,
//       userId: userId
//     );
//   }
// }