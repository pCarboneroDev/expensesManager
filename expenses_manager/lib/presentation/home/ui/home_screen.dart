import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/home/bloc/home_bloc.dart';
import 'package:expenses_manager/presentation/home/ui/widgets/balance_card.dart';
import 'package:expenses_manager/presentation/home/ui/widgets/movements_home.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadLastMovementsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Settings'), leading: Icon(Icons.settings), onTap: () {}),
            ListTile(title: const Text('Account'), leading: Icon(FontAwesomeIcons.person), onTap: () {}),
            ListTile(title: const Text('Item 2'), onTap: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pushNamed(context, 'create_transaction'); },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final status = <UIStatus, Widget>{
            UIStatus.error: Center(child: Text(state.uiState.errorMessage)),
            UIStatus.loading: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            UIStatus.idle: Center(child: Text('Idle')),
            UIStatus.success: _MainScreen(
              monthExpenses: state.monthExpenses,
              monthIncome: state.monthIncome,
              lastMovements: state.lastMovements,
            ),
          };
          return status[state.uiState.status] ?? Container();
        },
      ),
    );
  }
}

class _MainScreen extends StatelessWidget {
  final double monthIncome;
  final double monthExpenses;
  final List<TransactionModel> lastMovements;

  const _MainScreen({
    required this.monthIncome,
    required this.monthExpenses,
    required this.lastMovements,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: ListView(
        children: [
          Text(
            'Month balance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          BalanceCard(monthExpenses: monthExpenses, monthIncome: monthIncome),

          SizedBox(height: 40),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'movements');
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Last movements',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black45),
                  ],
                ),
                // aqui probablemente ira un bucle con un listView para que aparezcan las cosas
                ...lastMovements.map((e) {
                  return MovementHome(movement: e);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
