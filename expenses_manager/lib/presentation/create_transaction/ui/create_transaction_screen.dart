import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/CreateTransactionForm.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateTransactionBloc>(context).add(LoadCategories());
    amountController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.watch<CreateTransactionBloc>().state;
    _updateControllerFromState(state);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _updateControllerFromState(CreateTransactionState state) {
    final currentText = amountController.text;
    final expectedText = state.amount > 0 ? state.amount.toString() : '';

    if (currentText != expectedText && !(FocusScope.of(context).hasFocus)) {
      amountController.text = expectedText;
    }
  }

  void updateDate(DateTime date) {
    BlocProvider.of<CreateTransactionBloc>(
      context,
    ).add(UpdateTransactionDate(date));
  }

  void updateCategory(CategoryModel category) {
    BlocProvider.of<CreateTransactionBloc>(
      context,
    ).add(UpdateTransactionCategory(category));
  }

  void updateType(TransactionType type) {
    BlocProvider.of<CreateTransactionBloc>(
      context,
    ).add(UpdateTransactionType(type));
  }

  void updateAmount(double amount) {
    BlocProvider.of<CreateTransactionBloc>(
      context,
    ).add(UpdateTransactionAmount(amount));
  }

  void createTransaction(TransactionModel transaction) {
    BlocProvider.of<CreateTransactionBloc>(
      context,
    ).add(CreateTransaction(transaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Transacción'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
        builder: (context, state) {
          final status = <UIStatus, Widget>{
            UIStatus.error: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.uiState.errorMessage,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CreateTransactionBloc>().add(
                        LoadCategories(),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
            UIStatus.loading: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            UIStatus.success: CreateTransactionForm(
              categories: state.categories,
              selectedType: state.type,
              selectedDate: state.date,
              selectedCategory: state.category,
              quantity: state.amount,
              amountController: amountController,

              updateDate: updateDate,
              updateCategory: updateCategory,
              updateType: updateType,
              create: createTransaction,
              updateAmount: updateAmount,
            ),
            UIStatus.idle: const Center(child: Text('IDLE')),
          };
          print(state.amount);
          return status[state.uiState.status] ?? Container();
        },
      ),
    );
  }
}
