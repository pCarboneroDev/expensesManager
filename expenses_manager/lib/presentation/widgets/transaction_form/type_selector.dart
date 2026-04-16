import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class TypeSelector extends StatelessWidget {
  final TransactionType selectedType;
  final void Function(TransactionType) updateType;

  const TypeSelector({super.key, required this.selectedType, required this.updateType});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorScheme.of(context).surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: _TypeOption(
                selectedType: selectedType,
                typeOption: TransactionType.expense,
                icon: Icons.arrow_upward,
                label: 'Expense',
                color: ColorScheme.of(context).error,
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
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => updateType(typeOption),
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
