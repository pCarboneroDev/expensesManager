import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/category_selector.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/date_card.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/quantity_field.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/type_selector.dart';
import 'package:flutter/material.dart';

class CreateTransactionForm extends StatelessWidget {
  final List<CategoryModel> categories;
  final TransactionType selectedType;
  final DateTime selectedDate;
  final CategoryModel? selectedCategory;
  final double quantity;

  final void Function(DateTime) updateDate;
  final void Function(CategoryModel) updateCategory;
  final void Function(TransactionType) updateType;

  const CreateTransactionForm({
    required this.categories,
    required this.selectedType,
    required this.selectedDate,
    required this.selectedCategory,
    required this.quantity,
    required this.updateDate,
    required this.updateCategory,
    required this.updateType,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeSelector(selectedType: selectedType, updateType: updateType),
          const SizedBox(height: 20),
          QuantityField(controller: amountController),
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

                // Crear la transacción (aquí normalmente llamarías a tu servicio/backend)
                final transaction = TransactionModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  date: selectedDate,
                  quantity: amount,
                  category: selectedCategory!,
                  type: selectedType,
                );
                // todo mandar al bloc

                // Mostrar mensaje de éxito y regresar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${selectedType == TransactionType.expense ? "Gasto" : "Ingreso"} creado con éxito',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context, transaction);
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