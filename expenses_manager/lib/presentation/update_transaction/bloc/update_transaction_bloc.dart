import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/update_params.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/update_transaction_usecase.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';

part 'update_transaction_event.dart';
part 'update_transaction_state.dart';

class UpdateTransactionBloc extends Bloc<UpdateTransactionEvent, UpdateTransactionState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final UpdateTransactionUsecase updateTransactionUsecase;

  UpdateTransactionBloc(
    this.getCategoriesUsecase, 
    this.updateTransactionUsecase
    ): super(
        UpdateTransactionState(
          uiState: UIState.idle(),
          newTransaction: TransactionModel.empty(),
          amount: 0,
          date: DateTime.now(),
          category: CategoryModel(id: 0, name: "", icon: Icons.restaurant),
          type: TransactionType.expense,
          categories: [],
          transactionId: 0
        ),
      ) {
    on<UpdateTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadCategories>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));

      final result = await getCategoriesUsecase.call(null);

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (categories) => emit(state.copyWith(uiState: UIState.success(), categories: categories, category: categories[0]))
      );
    });

    on<UpdateTransactionType>((event, emit) async {
      emit(state.copyWith(type: event.type));
    });

    on<UpdateTransactionDate>((event, emit) async {
      emit(state.copyWith(date: event.date));
    });

    on<UpdateTransactionCategory>((event, emit) async {
      emit(state.copyWith(category: event.category));
    });

    on<UpdateTransactionAmount>((event, emit) async {
      emit(state.copyWith(amount: event.amount));
    });

    on<UpdateTransactionId>((event, emit) async {
      emit(state.copyWith(transactionId: event.id));
    });

    on<UpdateTransaction>((event, emit) async {
     emit(state.copyWith(uiState: UIState.loading()));

      final result = await updateTransactionUsecase.call(UpdateParams(transactionId: state.transactionId, transaction: event.transaction));

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (categories) => emit(state.copyWith(uiState: UIState.success()))
      );
    });
  }
}
