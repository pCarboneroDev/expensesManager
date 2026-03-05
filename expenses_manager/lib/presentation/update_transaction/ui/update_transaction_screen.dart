import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/CreateTransactionForm.dart';
import 'package:expenses_manager/presentation/update_transaction/bloc/update_transaction_bloc.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTransactionScreen extends StatefulWidget {
  const UpdateTransactionScreen({super.key});

  @override
  State<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  TransactionModel? transaction;
  bool _categoriesLoaded = false;
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<UpdateTransactionBloc>(context);
    bloc.add(LoadCategories());
    amountController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transaction = ModalRoute.of(context)!.settings.arguments as TransactionModel;
    final state = context.watch<UpdateTransactionBloc>().state;
    _updateControllerFromState(state);
  }

  void _updateControllerFromState(UpdateTransactionState state) {
    final currentText = amountController.text;
    final expectedText = state.amount > 0 ? state.amount.toString() : '';

    if (currentText != expectedText && !(FocusScope.of(context).hasFocus)) {
      amountController.text = expectedText;
    }
  }

  void updateDate(DateTime date) {
    BlocProvider.of<UpdateTransactionBloc>(context).add(UpdateTransactionDate(date));
  }

  void updateCategory(CategoryModel category) {
    BlocProvider.of<UpdateTransactionBloc>(
      context,
    ).add(UpdateTransactionCategory(category));
  }

  void updateType(TransactionType type) {
    BlocProvider.of<UpdateTransactionBloc>(context).add(UpdateTransactionType(type));
  }

    void updateAmount(double amount) {
    BlocProvider.of<UpdateTransactionBloc>(context).add(UpdateTransactionAmount(amount));
  }

  void createTransaction(TransactionModel transaction) {
    BlocProvider.of<UpdateTransactionBloc>(context).add(UpdateTransaction(transaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update transaction'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<UpdateTransactionBloc, UpdateTransactionState>(
        listener: (context, state) {
          if (state.uiState.status == UIStatus.success && !_categoriesLoaded) {
            final bloc = BlocProvider.of<UpdateTransactionBloc>(context);
            _categoriesLoaded = true;

            // Verificar que la categoría existe en la lista cargada
            final categoryExists = state.categories.any(
              (c) => c.id == transaction!.category.id,
            );

            if (categoryExists) {
              bloc.add(UpdateTransactionCategory(transaction!.category));
            }

            bloc.add(UpdateTransactionDate(transaction!.date));
            bloc.add(UpdateTransactionType(transaction!.type));
            bloc.add(UpdateTransactionAmount(transaction!.amount));
            bloc.add(UpdateTransactionId(transaction!.id));
          }
        },
        child: BlocBuilder<UpdateTransactionBloc, UpdateTransactionState>(
          builder: (context, state) {
            final status = <UIStatus, Widget>{
              UIStatus.error: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.uiState.errorMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UpdateTransactionBloc>().add(
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
            return status[state.uiState.status] ?? Container();
          },
        ),
      ),
    );
  }
}
