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
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
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
                            Icon(Icons.food_bank, size: 50,),
                            Text(state.transactionList[index].category.name, style: TextStyle(fontSize: 20)),
                            Text("${state.transactionList[index].type == TransactionType.income ? '+' : '-'}${state.transactionList[index].quantity}€", style: TextStyle(fontSize: 30))
                          ],
                        ),
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