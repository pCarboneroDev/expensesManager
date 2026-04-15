import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/domain/models/params/filter_transactions_params.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/delete_transaction_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_filtered_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_month_transactions_usecase.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetMonthTransactionsUsecase getMonthTransactionsUsecase;
  final DeleteTransactionUsecase deleteTransactionUsecase;
  final GetFilteredTransactionsUsecase getFilteredTransactionsUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;

  TransactionBloc(
    this.getMonthTransactionsUsecase,
    this.deleteTransactionUsecase,
    this.getFilteredTransactionsUsecase,
    this.getCategoriesUsecase
  ) : super(
    TransactionState(
      uiState: UIState.idle(), 
      transactionList: {},
      categories: [],
      dateFilterOptions: ['Month', 'Year', 'Week', 'Day'],
      selectedCategory: 0,
      selectedDateOption: '',
      contentLoading: false
    )) {
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnLoadMonthTransactions>((event, emit) async {
      emit(state.copyWith(uiState: UIState.loading()));

      final Future<Either<Failure, Map<DateTime, List<TransactionModel>>>> transctionsFuture = getFilteredTransactionsUsecase.call(
        FilterTransactionsParams(
          date: 'Month'
        )
      );
      final Future<Either<Failure, List<CategoryModel>>> categoriesFuture = getCategoriesUsecase.call(null); //todo ver si es mejor quitar el null

      final results = await Future.wait([transctionsFuture, categoriesFuture]);

      final Either<Failure, Map<DateTime, List<TransactionModel>>> transactions = results[0] as Either<Failure, Map<DateTime, List<TransactionModel>>>;
      final Either<Failure, List<CategoryModel>> categories = results[1] as Either<Failure, List<CategoryModel>>;


      categories.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (categories) => emit(state.copyWith(categories: [CategoryModel(id: 0, name: 'All', icon: Icons.abc), ...categories], selectedCategory: 0, selectedDateOption: state.dateFilterOptions.first))
      );

      transactions.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (transactions) => emit(state.copyWith(uiState: UIState.success(), transactionList: transactions))
      );
    });

    on<FilterCategory>((event, emit) async {
      emit(state.copyWith(contentLoading: true));

      final result = await getFilteredTransactionsUsecase.call(
        FilterTransactionsParams(
          categoryId: event.id,
          date: state.selectedDateOption
        )
      );

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (transactions) => emit(state.copyWith(contentLoading: false, transactionList: transactions, uiState: UIState.success(), selectedCategory: event.id))
      );
    });

    on<FilterDateEvent>((event, emit) async {
      emit(state.copyWith(contentLoading: true));

      final result = await getFilteredTransactionsUsecase.call(
        FilterTransactionsParams(
          //categoryId: state.selectedCategory,
          date: event.date
        )
      );

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (transactions) => emit(state.copyWith(contentLoading: false, transactionList: transactions, uiState: UIState.success(), selectedDateOption: event.date))
      );
    });

    on<DeleteTransaction>((event, emit) async {
      //emit(state.copyWith(uiState: UIState.loading())); //! por algún motivo eso lo rompe, no entiendo nada
      final result = await deleteTransactionUsecase.call(event.transactionId);

      result.fold(
        (fail) => emit(state.copyWith(uiState: UIState.error(fail.message))),
        (ok) => emit(
          state.copyWith(
            uiState: UIState.success()
          )
        ),
      );
    });
  }
}
