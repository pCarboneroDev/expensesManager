import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final double monthIncome;
  final double monthExpenses;

  const BalanceCard({required this.monthIncome, required this.monthExpenses});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: 'en_EN', symbol: '€');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Month resume',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard(
                  'Incomes',
                  numberFormat.format(monthIncome),
                  Colors.green,
                ),
                _buildSummaryCard(
                  'Expenses',
                  numberFormat.format(monthExpenses),
                  Colors.red,
                ),
                _buildSummaryCard(
                  'Balance',
                  numberFormat.format(monthIncome - monthExpenses),
                  (monthIncome - monthExpenses) >= 0
                      ? Colors.blue
                      : Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Indicador de porcentaje gastado vs ingresado
            LinearProgressIndicator(
              value: monthIncome > 0
                  ? (monthExpenses / monthIncome).clamp(0.0, 1.0)
                  : 0.0,
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Text(
              'You have spent ${((monthExpenses / monthIncome) * 100).toStringAsFixed(1)}% of your incomes.',
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSummaryCard(String title, String amount, Color color) {
  return Column(
    children: [
      Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      SizedBox(height: 8),
      Text(
        amount,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
