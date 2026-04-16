import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/category_color.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  
  // Cache colors or use a provider/extension method
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final categoryColor = getCategoryColor(transaction.category.name);
    
    return Material(
      borderRadius: BorderRadius.circular(13),
      color: colorScheme.surfaceContainerLow,
      child: InkWell(
        borderRadius: BorderRadius.circular(13), // Match Material's radius
        onTap: () => _navigateToUpdate(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _buildCategoryIcon(categoryColor),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCategoryName(context),
              ),
              const SizedBox(width: 12),
              _buildAmountText(context),
            ],
          ),
        ),
      ),
    );
  }
  
  void _navigateToUpdate(BuildContext context) {
    Navigator.pushNamed(
      context,
      'update_transaction',
      arguments: transaction,
    );
  }
  
  Widget _buildCategoryIcon(Color color) {
    return Icon(
      transaction.category.icon,
      size: 40,
      color: color,
    );
  }
  
  Widget _buildCategoryName(BuildContext context) {
    return Text(
      transaction.category.name,
      style: Theme.of(context).textTheme.bodyLarge,
      overflow: TextOverflow.ellipsis,
    );
  }
  
  Widget _buildAmountText(BuildContext context) {
    final sign = transaction.type == TransactionType.income ? '+' : '-';
    final color = transaction.type == TransactionType.income 
        ? Theme.of(context).colorScheme.primary 
        : Theme.of(context).colorScheme.error;
    
    return Text(
      "$sign${transaction.amount.toStringAsFixed(2)}€",
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
// class TransactionCard extends StatelessWidget {
//   final TransactionModel transaction;

//   const TransactionCard({super.key, required this.transaction});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(13),
//       color: ColorScheme.of(context).surfaceContainer,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             'update_transaction',
//             arguments: transaction,
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(transaction.category.icon, size: 40, color: getCategoryColor(transaction.category.name),),
//               Text(transaction.category.name, style: TextStyle(fontSize: 15)),
//               Text(
//                 "${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount}€",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }