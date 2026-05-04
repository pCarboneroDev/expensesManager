import 'package:expenses_manager/utils/category_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesCategoryDistributionChart extends StatelessWidget {
  const ExpensesCategoryDistributionChart({
    super.key,
    required this.expensesByCategory,
    required this.totalExpense,
    required this.numberFormat,
  });

  final Map<String, double> expensesByCategory;
  final double totalExpense;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expenses distribution',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          expensesByCategory.isEmpty
              ? Center(child: Text('No hay datos de gastos'))
              : SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(
                        totalExpense,
                        expensesByCategory,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
          SizedBox(height: 20),
          // Leyenda de colores
          Wrap(
            spacing: 10,
            children: expensesByCategory.keys.map((category) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: getCategoryColor(category),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '$category (${numberFormat.format(expensesByCategory[category])})',
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}


List<PieChartSectionData> _buildPieChartSections(
  double totalExpense,
  Map<String, double> expensesByCategory,
) {
  if (totalExpense == 0) return [];

  return expensesByCategory.entries.map((entry) {
    final percentage = (entry.value / totalExpense) * 100;
    return PieChartSectionData(
      value: entry.value,
      title: '${percentage.toStringAsFixed(0)}%',
      color: getCategoryColor(entry.key),
      radius: 80,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }).toList();
}