import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/home/bloc/home_bloc.dart';
import 'package:expenses_manager/presentation/home/ui/widgets/balance_card.dart';
import 'package:expenses_manager/presentation/home/ui/widgets/home_transaction_card.dart';
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
    load();
  }
  void load(){
    BlocProvider.of<HomeBloc>(context).add(LoadLastMovementsEvent());
  }

  void signOut() {
    BlocProvider.of<HomeBloc>(context).add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Settings'), leading: Icon(Icons.settings), onTap: () {}),
            ListTile(title: const Text('Account'), leading: Icon(FontAwesomeIcons.person), onTap: () {}),
            ListTile(
              tileColor: ColorScheme.of(context).error,
              title: const Text('SignOut'), 
              leading: Icon(FontAwesomeIcons.arrowRightFromBracket), 
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sign out'),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            signOut();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: ColorScheme.of(context).errorContainer,
                          ),
                          child: Text('Sign out', style: TextStyle(color: ColorScheme.of(context).onErrorContainer)),
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pushNamed(context, 'create_transaction').then((_) => load()); },
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
              load: load,
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
  final Function load;

  const _MainScreen({
    required this.monthIncome,
    required this.monthExpenses,
    required this.lastMovements,
    required this.load
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
              fontWeight: FontWeight.bold
            ),
          ),
          BalanceCard(monthExpenses: monthExpenses, monthIncome: monthIncome),

          SizedBox(height: 40),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'transactions');
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Last transactions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                // aqui probablemente ira un bucle con un listView para que aparezcan las cosas
                ...lastMovements.map((e) {
                  return HomeTransactionCard(transaction: e, load: load);
                  //return MovementHome(movement: e);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
