import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:expenses_manager/presentation/transactions/ui/widgets/filter_container.dart';
import 'package:expenses_manager/presentation/transactions/ui/widgets/transaction_list.dart';
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

  void deleteTransaction(int transactionId) {
    BlocProvider.of<TransactionBloc>(
      context,
    ).add(DeleteTransaction(transactionId: transactionId));
  }

  void filterCategory(int id) {
    BlocProvider.of<TransactionBloc>(context).add(FilterCategory(id: id));
  }

  void filterDate(String date) {
    BlocProvider.of<TransactionBloc>(context).add(FilterDateEvent(date: date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your transactions')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'create_transaction');
        },
        child: Icon(Icons.add),
      ),
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
                FilterContainer(
                  categories: state.categories,
                  dateOptions: state.dateFilterOptions,
                  selectedDate: state.selectedDateOption,
                  selectedCategory: state.selectedCategory,
                  filter: filterCategory,
                  filterDate: filterDate,
                ),

                if(state.contentLoading == true)
                Expanded(child: CircularProgressIndicator.adaptive())
                else if (state.transactionList.isEmpty)
                Expanded(child: Center(child: Text('No hay na :3')))
                else
                TransactionList(
                  transactionList: state.transactionList,
                  deleteTransaction: deleteTransaction,
                ),
              ],
            ),
          };
          return status[state.uiState.status] ?? Container();
        },
      ),
    );
  }
}
