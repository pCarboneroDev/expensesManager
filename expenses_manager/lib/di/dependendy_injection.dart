import 'package:expenses_manager/data/mock_datasource.dart';
import 'package:expenses_manager/data/repositories_impl/categories_repository_impl.dart';
import 'package:expenses_manager/data/repositories_impl/transactions_repository_impl.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_last_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_month_transactions_usecase.dart';
import 'package:expenses_manager/presentation/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:expenses_manager/presentation/home/bloc/home_bloc.dart';
import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  //datasources
  getIt.registerSingleton(MockDatasource());

  // repositories
  getIt.registerSingleton<TransactionsRepository>(TransactionsRepositoryImpl(getIt()));
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepositoryImpl(getIt()));

  // usecases
  getIt.registerSingleton(GetLastTransactionsUsecase(getIt()));
  getIt.registerSingleton(GetMonthTransactionsUsecase(getIt()));

  getIt.registerSingleton(GetCategoriesUsecase(getIt()));


  // blocs
  getIt.registerSingleton(HomeBloc(getIt()));
  getIt.registerSingleton(TransactionBloc(getIt()));
  getIt.registerSingleton(CreateTransactionBloc(getIt()));
}