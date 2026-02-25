import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(OnLoadMonthTransactions());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your transactions'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {Navigator.pushNamed(context, 'create_transaction');}, child: Icon(Icons.add)),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          final status = <UIStatus, Widget>{
            UIStatus.error: Center(child: Text(state.uiState.errorMessage)),
            UIStatus.loading: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            UIStatus.idle: Center(child: Text('Idle')),
            UIStatus.success: Column(
              children: [
                _FilterContainer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.transactionList.length,
                    itemBuilder: (context, index) {
                      final date = state.transactionList.keys.elementAt(index);
                      final dayTransactions = state.transactionList[date]!;

                      return Column(
                        children: [
                          _DateCard(date: date),
                          
                          ...dayTransactions.map((transaction) {
                            return _TransactionCard(transaction: transaction,);
                          }).toList(),
                                    ],
                      );
                    }
                  ),
                )
              ],
            ),
          };
          return status[state.uiState.status] ?? Container();
        },
      )
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionCard({
    required this.transaction
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(110, 185, 155, 255),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(transaction.category.icon, size: 50),
          Text(
            transaction.category.name, 
            style: TextStyle(fontSize: 20)
          ),
          Text(
            "${transaction.type == TransactionType.income ? '+' : '-'}${transaction.quantity}€", 
            style: TextStyle(fontSize: 30)
          )
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.grey.shade200,
      width: double.infinity,
      child: Text(
        _formatDate(date),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FilterContainer extends StatelessWidget {
  const _FilterContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorScheme.light().surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 0, 0, 0),
            offset: Offset(0, 3),
            blurRadius: BorderSide.strokeAlignOutside,
            spreadRadius: BorderSide.strokeAlignOutside,
          )
        ]
      ),
      child: Row(
        children: [
          ElevatedButton(onPressed: () {}, child: Icon(Icons.search)),
          Spacer(),
          ElevatedButton(onPressed: () {}, child: Text('Month')),
          SizedBox(width: 20),
          ElevatedButton(onPressed: () {}, child: Text('All (category)'))
        ],
      ),
    );
  }
}


String _formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  
  if (date == today) {
    return 'Hoy';
  } else if (date == yesterday) {
    return 'Ayer';
  } else {
    // Formato: "lunes, 25 de febrero"
    final weekdays = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
    final months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    
    return '${weekdays[date.weekday - 1]}, ${date.day} de ${months[date.month - 1]}';
  }
}