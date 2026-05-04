import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PredictionCard extends StatelessWidget {
  const PredictionCard({
    super.key,
    required this.primary,
    required this.prediction,
    required this.totalIncome,
    required this.numberFormat
  });

  final Color primary;
  final double prediction;
  final double totalIncome;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Row(
              children: [
                Icon(Icons.trending_up, color: primary),
                const SizedBox(width: 8),
                const Text(
                  "Month prediction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Gasto proyectado
            const Text(
              "Based on your behaviour this month, you are expected to spent a total of:",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              numberFormat.format(prediction),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 12),

            // Comportamiento
            _BehaviourSection(
              prediction: prediction,
              income: totalIncome,
            ),
            const SizedBox(height: 12),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     DetailChip(
            //       icon: Icons.calendar_today,
            //       label: "23/30 días",
            //     ),
            //     DetailChip(
            //       icon: Icons.attach_money,
            //       label: "Promedio diario: 23"
            //       //"Promedio diario: \$${( / diasTranscurridos).toStringAsFixed(2)}",
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class _BehaviourSection extends StatelessWidget {
  const _BehaviourSection({
    required this.income,
    required this.prediction,
  });

  final double income;
  final double prediction;

  String text(double diff) {
    if (diff > 0) {
      return "Good control";
    } else if (diff == 0) {
      return "Careful, you are close to your total incomes";
    } else {
      return "You have exceded your total icomes in this month";
    }
  }

  Color color(double diff) {
    if (diff > 0) {
      return Colors.green;
    } else if (diff == 0) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  IconData icon(double diff) {
    if (diff > 0) {
      return Icons.check_circle_outline;
    } else if (diff == 0) {
      return Icons.warning_amber_outlined;
    } else {
      return Icons.dangerous_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final diff = income - prediction;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color(diff).withAlpha(29),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon(diff), color: color(diff)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your behaviour",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  text(diff),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color(diff),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
