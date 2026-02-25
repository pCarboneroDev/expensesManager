import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';

part 'create_transaction_event.dart';
part 'create_transaction_state.dart';

class CreateTransactionBloc extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  CreateTransactionBloc(this.getCategoriesUsecase)
    : super(
        CreateTransactionState(
          uiState: UIState.idle(),
          newTransaction: TransactionModel.empty(),
          quantity: 0,
          date: DateTime.now(),
          category: CategoryModel(id: 0, name: "", icon: Icons.restaurant),
          type: TransactionType.expense,
          categories: [],
        ),
      ) {
    on<CreateTransactionEvent>((event, emit) {
      // 
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
  }
}
