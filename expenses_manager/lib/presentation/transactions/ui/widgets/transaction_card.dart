import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { Navigator.pushNamed(context, 'update_transaction', arguments: transaction); },
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(110, 185, 155, 255),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(transaction.category.icon, size: 50),
            Text(transaction.category.name, style: TextStyle(fontSize: 20)),
            Text(
              "${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount}€",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}