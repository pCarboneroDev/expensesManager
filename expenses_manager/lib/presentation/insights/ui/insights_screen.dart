import 'package:expenses_manager/presentation/insights/bloc/insights_bloc.dart';
import 'package:expenses_manager/presentation/insights/ui/widgets/custom_expenses_line_chart.dart';
import 'package:expenses_manager/presentation/insights/ui/widgets/expenses_categoty_distribution_chart.dart';
import 'package:expenses_manager/presentation/insights/ui/widgets/prediction_card.dart';
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
    BlocProvider.of<InsightsBloc>(context).add(LoadCategoriesEvent());
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
              prediction: state.prediction,
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
  final double prediction;

  const _InsightsMainScreen({
    required this.totalIncome,
    required this.totalExpense,
    required this.expensesByCategory,
    required this.expensesMonth,
    required this.expensesDay,
    required this.tabController,
    required this.prediction,
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

    final numberFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Full analytic",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "Hi User, Here's a showcase of your analytics.",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
        //_ExpensesCategoryDistributionChart(expensesByCategory: expensesByCategory, totalExpense: totalExpense, numberFormat: numberFormat),
        Column(
          children: [
            BlocBuilder<InsightsBloc, InsightsState>(
              builder: (context, state) {
                return AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: BlocBuilder<InsightsBloc, InsightsState>(
                    builder: (context, state) {
                      if (state.predictionLoading) {
                        return Card(
                          child: SizedBox(
                            height: 100, // Altura fija o mínima
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        );
                      } else {
                        return PredictionCard(
                          primary: primary,
                          prediction: prediction,
                          totalIncome: totalIncome,
                          numberFormat: numberFormat,
                        );
                      }
                    },
                  ),
                );
              },
            ),

            TabBar(
              controller: tabController,
              tabs: [
                Tab(child: Text("Month")),
                Tab(child: Text("Week")),
              ],
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 280,
              child: TabBarView(
                controller: tabController,
                children: [
                  expensesMonth.isEmpty
                      ? Center(child: Text('No hay datos de gastos'))
                      : CustomExpensesLineChart(
                          spots: spots,
                          primary: primary,
                          order: monthsOrder,
                        ),

                  expensesDay.isEmpty
                      ? Center(child: Text('No hay datos de gastos'))
                      : CustomExpensesLineChart(
                          spots: spotsDay,
                          primary: primary,
                          order: daysOrder,
                        ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Divider(),
        SizedBox(height: 10),

        ExpensesCategoryDistributionChart(
          expensesByCategory: expensesByCategory,
          totalExpense: totalExpense,
          numberFormat: numberFormat,
        ),
      ],
    );
  }
}