import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomExpensesLineChart extends StatelessWidget {
  const CustomExpensesLineChart({
    super.key,
    required this.spots,
    required this.primary,
    required this.order,
  });

  final List<FlSpot> spots;
  final Color primary;
  final List<String> order;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: primary,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: primary.withAlpha(30)),
          ),
        ],

        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index >= 0 && index < order.length) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      order[index].substring(0, 3),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
                // Return an empty widget for any out-of-range values
                return const Text("data");
              },
            ),
          ),
        ),
      ),
    );
  }
}