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

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InsightsBloc>(context).add(LoadCategoriesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insights"),),
      body: BlocBuilder<InsightsBloc, InsightsState>(
        builder: (context, state) {
          final status = <UIStatus, Widget> {
            UIStatus.idle: Center(child: Text("IDLE")),
            UIStatus.error: Center(child: Text("ERROR")),
            UIStatus.loading: Center(child: CircularProgressIndicator.adaptive()),
            UIStatus.success: _InsightsMainScreen(
              expensesByCategory: state.categoryMap,
              totalExpense: state.finalExpense,
              totalIncome: state.finalIncome,
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

  const _InsightsMainScreen({
    required this.totalIncome,
    required this.totalExpense,
    required this.expensesByCategory
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expenses distribution', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 20),
                  expensesByCategory.isEmpty 
                      ? Container(height: 200, child: Center(child: Text('No hay datos de gastos')))
                      : SizedBox(
                          height: 250,
                          child: PieChart(
                            PieChartData(
                              sections: _buildPieChartSections(totalExpense, expensesByCategory),
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
                          Container(width: 16, height: 16, color: getCategoryColor(category)),
                          SizedBox(width: 5),
                          Text('$category (${numberFormat.format(expensesByCategory[category])})'),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),


          //------------------------------------------------------------------------------------------------

          // Card(
          //   child: Padding(
          //     padding: const EdgeInsetsGeometry.all(8),
          //     child: Column(
          //       children: [
          //         Chart
          //       ],
          //     ),
          //   ),
          // )
        ],
      );
  }

  // Convierte el Map de categorías en una lista de PieChartSectionData
  List<PieChartSectionData> _buildPieChartSections(double totalExpense, Map<String, double> expensesByCategory) {
    if (totalExpense == 0) return [];

    return expensesByCategory.entries.map((entry) {
      final percentage = (entry.value / totalExpense) * 100;
      return PieChartSectionData(
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        color: getCategoryColor(entry.key),
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }
}

