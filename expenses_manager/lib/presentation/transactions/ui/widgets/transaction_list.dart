import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/transactions/ui/widgets/date_label.dart';
import 'package:expenses_manager/presentation/transactions/ui/widgets/delete_modal.dart';
import 'package:expenses_manager/presentation/transactions/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final Map<DateTime, List<TransactionModel>> transactionList;
  final void Function(int) deleteTransaction;
  
  const TransactionList({super.key, required this.transactionList, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          final date = transactionList.keys.elementAt(index);
          final dayTransactions = transactionList[date]!;

          return Column(
            children: [
              DateLabel(date: date),

              ...dayTransactions.map((transaction) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dismissible( //todo creo que si esto lo pones en el card se ve bien 
                    key: Key(transaction.id.toString()),
                    background: Container(
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      child: Row(children: [Spacer(), Icon(Icons.delete_outline, color: ColorScheme.of(context).error,)],),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (context) => DeleteModal(),
                      );
                    },
                    onDismissed: (direction) {
                      deleteTransaction(transaction.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: TransactionCard(transaction: transaction),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
