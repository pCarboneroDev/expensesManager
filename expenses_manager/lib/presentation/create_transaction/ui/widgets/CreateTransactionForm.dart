import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/category_selector.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/date_card.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/amount_field.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/type_selector.dart';
import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionForm extends StatelessWidget {
  final List<CategoryModel> categories;
  final TransactionType selectedType;
  final DateTime selectedDate;
  final CategoryModel? selectedCategory;
  final double quantity;
  final TextEditingController amountController;

  final void Function(DateTime) updateDate;
  final void Function(CategoryModel) updateCategory;
  final void Function(TransactionType) updateType;
  final void Function(TransactionModel) create;
  final void Function(double) updateAmount;

  const CreateTransactionForm({
    super.key,
    required this.categories,
    required this.selectedType,
    required this.selectedDate,
    required this.selectedCategory,
    required this.quantity,
    required this.updateDate,
    required this.updateCategory,
    required this.updateType,
    required this.create, 
    required this.updateAmount, required this.amountController
  });

  @override
  Widget build(BuildContext context) {
    amountController.text = (quantity > 0) ? quantity.toString() : '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeSelector(selectedType: selectedType, updateType: updateType),
          const SizedBox(height: 20),
          AmountField(controller: amountController, updateAmount: updateAmount),
          const SizedBox(height: 20),
          DateCard(selectedDate: selectedDate, updateDate: updateDate),
          const SizedBox(height: 20),
          CategorySelector(
            categories: categories,
            selectedCategory: selectedCategory,
            updateCategory: updateCategory,
          ),
          const SizedBox(height: 20),
          // boton
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor ingresa un monto')),
                  );
                  return;
                }

                if (selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor selecciona una categoría'),
                    ),
                  );
                  return;
                }

                final amount = double.tryParse(amountController.text);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor ingresa un monto válido'),
                    ),
                  );
                  return;
                }

                final transaction = TransactionModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  date: selectedDate,
                  amount: amount,
                  category: selectedCategory!,
                  type: selectedType,
                );
                // mandar al bloc
                create(transaction);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${selectedType == TransactionType.expense ? "Expense" : "Income"} created', 
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                // todo revisar si esto es buena práctica
                context.read<TransactionBloc>().add(OnLoadMonthTransactions());
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Guardar transacción',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}