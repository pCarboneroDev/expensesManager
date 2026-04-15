import 'package:expenses_manager/presentation/insights/bloc/insights_bloc.dart';
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
    super.key,
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
          // 1. Tarjeta resumen (Gastado vs Ingresado)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Resumen del mes', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryCard('💰 Ingresos', numberFormat.format(totalIncome), Colors.green),
                      _buildSummaryCard('💸 Gastos', numberFormat.format(totalExpense), Colors.red),
                      _buildSummaryCard('📊 Balance', numberFormat.format(totalIncome - totalExpense), 
                                        (totalIncome - totalExpense) >= 0 ? Colors.blue : Colors.orange),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Indicador de porcentaje gastado vs ingresado
                  LinearProgressIndicator(
                    value: totalIncome > 0 ? (totalExpense / totalIncome).clamp(0.0, 1.0) : 0.0,
                    backgroundColor: Colors.grey[300],
                    color: Colors.red,
                    minHeight: 10,
                  ),
                  SizedBox(height: 10),
                  Text('Has gastado el ${((totalExpense / totalIncome) * 100).toStringAsFixed(1)}% de tus ingresos.'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // 2. Gráfica de gastos por categoría
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distribución de Gastos', style: Theme.of(context).textTheme.titleLarge),
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
                          Container(width: 16, height: 16, color: _getCategoryColor(category)),
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
        ],
      );
  }

  // Helper para construir las tarjetas pequeñas de resumen
  Widget _buildSummaryCard(String title, String amount, Color color) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        SizedBox(height: 8),
        Text(amount, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
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
        color: _getCategoryColor(entry.key),
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  // Asigna un color a cada categoría (puedes mejorarlo)
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food': return Colors.orange;
      case 'Clothing': return Colors.blue;
      case 'Entertaiment': return Colors.purple;
      default: return Colors.grey;
    }
  }
}

