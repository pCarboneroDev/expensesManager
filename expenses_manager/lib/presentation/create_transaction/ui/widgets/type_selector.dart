import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TypeSelector extends StatelessWidget {
  final TransactionType selectedType;
  final void Function(TransactionType) updateType;

  const TypeSelector({super.key, required this.selectedType, required this.updateType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _TypeOption(
              selectedType: selectedType,
              typeOption: TransactionType.expense,
              icon: Icons.arrow_upward,
              label: 'Expense',
              color: Colors.red,
              updateType: updateType
            ),
          ),
          Expanded(
            child: _TypeOption(
              selectedType: selectedType,
              typeOption: TransactionType.income,
              icon: Icons.arrow_downward,
              label: 'Income',
              color: Colors.green,
              updateType: updateType
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  final TransactionType selectedType;
  final TransactionType typeOption;
  final IconData icon;
  final String label; 
  final Color color;
  final void Function(TransactionType) updateType;


  const _TypeOption({required this.selectedType, required this.typeOption, required this.label, required this.color, required this.icon, required this.updateType});

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedType == typeOption;
    return GestureDetector(
      onTap: () {
        updateType(typeOption);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
