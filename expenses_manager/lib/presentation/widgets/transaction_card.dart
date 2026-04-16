import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/category_color.dart';
import 'package:expenses_manager/utils/format_date.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(
            context,
            'update_transaction',
            arguments: transaction,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Icon with background
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  transaction.category.icon,
                  size: 30,
                  color: getCategoryColor(transaction.category.name)
                  // color: transaction.type == TransactionType.income
                  //     ? Colors.green.shade700
                  //     : Colors.red.shade700,
                ),
              ),
              SizedBox(width: 16),
            
              // Category and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.category.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      formatDate(transaction.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            
              // Amount
              Text(
                "${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount.toStringAsFixed(2)}€",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorScheme.of(context).primary
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
