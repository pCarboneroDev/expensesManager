import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/category_color.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(13),
      color: ColorScheme.of(context).surfaceContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () {
          Navigator.pushNamed(
            context,
            'update_transaction',
            arguments: transaction,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(transaction.category.icon, size: 40, color: getCategoryColor(transaction.category.name),),
              Text(transaction.category.name, style: TextStyle(fontSize: 20)),
              Text(
                "${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount}€",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}