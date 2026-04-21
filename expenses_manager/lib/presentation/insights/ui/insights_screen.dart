import 'package:expenses_manager/presentation/insights/bloc/insights_bloc.dart';
import 'package:expenses_manager/utils/category_color.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<InsightsBloc>(context).add(LoadCategoriesEvent());
    BlocProvider.of<InsightsBloc>(context).add(LoadMainInsight());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insights")),
      body: BlocBuilder<InsightsBloc, InsightsState>(
        builder: (context, state) {
          final status = <UIStatus, Widget>{
            UIStatus.idle: Center(child: Text("IDLE")),
            UIStatus.error: Center(child: Text("ERROR")),
            UIStatus.loading: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            UIStatus.success: _InsightsMainScreen(
              expensesByCategory: state.categoryMap,
              totalExpense: state.finalExpense,
              totalIncome: state.finalIncome,
              expensesMonth: state.expensesMonth,
              expensesDay: state.expensesDay,
              tabController: TabController(length: 2, vsync: this),
            ),
          };
          return status[state.uiState.status] ?? Container();
        },
      ),
    );
  }
}

class _InsightsMainScreen extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final Map<String, double> expensesByCategory;
  final Map<String, double> expensesMonth;
  final Map<String, double> expensesDay;
  final TabController tabController;

  const _InsightsMainScreen({
    required this.totalIncome,
    required this.totalExpense,
    required this.expensesByCategory,
    required this.expensesMonth,
    required this.expensesDay,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = ColorScheme.of(context).primary;
    final List<String> monthsOrder = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final List<String> daysOrder = [
      'Monday',
      'Tuesday',
      'Wednesdey',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    // Crear los spots para la línea
    List<FlSpot> spots = [];
    List<FlSpot> spotsDay = [];

    for (int i = 0; i < monthsOrder.length; i++) {
      String month = monthsOrder[i];
      double value = expensesMonth[month] ?? 0;
      spots.add(FlSpot(i.toDouble(), value));
    }

    for (int i = 0; i < daysOrder.length; i++) {
      String day = daysOrder[i];
      double value = expensesDay[day] ?? 0;
      spotsDay.add(FlSpot(i.toDouble(), value));
    }

    //final numberFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        //_ExpensesCategoryDistributionChart(expensesByCategory: expensesByCategory, totalExpense: totalExpense, numberFormat: numberFormat),
        Card(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(child: Text("Month")),
                    Tab(child: Text("Week")),
                  ],
                ),
                SizedBox(height: 20),

                SizedBox(
                  height: 250,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      expensesMonth.isEmpty
                          ? Center(child: Text('No hay datos de gastos'))
                          : _CustomExpensesLineChart(
                              spots: spots,
                              primary: primary,
                              order: monthsOrder,
                            ),

                      expensesDay.isEmpty
                          ? Center(child: Text('No hay datos de gastos'))
                          : _CustomExpensesLineChart(
                              spots: spotsDay,
                              primary: primary,
                              order: daysOrder,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomExpensesLineChart extends StatelessWidget {
  const _CustomExpensesLineChart({
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

class _ExpensesCategoryDistributionChart extends StatelessWidget {
  const _ExpensesCategoryDistributionChart({
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }
}

// Convierte el Map de categorías en una lista de PieChartSectionData
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
