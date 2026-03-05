import 'package:expenses_manager/data/mock_datasource.dart';
import 'package:expenses_manager/data/remote_datasource.dart';
import 'package:expenses_manager/data/repositories_impl/categories_repository_impl.dart';
import 'package:expenses_manager/data/repositories_impl/transactions_repository_impl.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';
import 'package:expenses_manager/domain/repositories/transactions_repository.dart';
import 'package:expenses_manager/domain/usecases/categories/get_categories_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/create_transaction_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/delete_transaction_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_filtered_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_last_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/get_month_transactions_usecase.dart';
import 'package:expenses_manager/domain/usecases/transactions/update_transaction_usecase.dart';
import 'package:expenses_manager/presentation/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:expenses_manager/presentation/home/bloc/home_bloc.dart';
import 'package:expenses_manager/presentation/login/bloc/login_bloc.dart';
import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:expenses_manager/presentation/update_transaction/bloc/update_transaction_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  //datasources
  getIt.registerSingleton(MockDatasource());
  getIt.registerSingleton(RemoteDatasource());

  // repositories
  getIt.registerSingleton<TransactionsRepository>(TransactionsRepositoryImpl(getIt(), getIt()));
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepositoryImpl(getIt(), getIt()));

  // usecases
  getIt.registerSingleton(GetLastTransactionsUsecase(getIt()));
  getIt.registerSingleton(GetMonthTransactionsUsecase(getIt()));
  getIt.registerSingleton(CreateTransactionUsecase(getIt()));
  getIt.registerSingleton(DeleteTransactionUsecase(getIt()));
  getIt.registerSingleton(UpdateTransactionUsecase(getIt()));
  getIt.registerSingleton(GetFilteredTransactionsUsecase(getIt()));

  getIt.registerSingleton(GetCategoriesUsecase(getIt()));


  // blocs
  getIt.registerSingleton(HomeBloc(getIt()));
  getIt.registerSingleton(TransactionBloc(getIt(), getIt(), getIt(), getIt()));
  getIt.registerSingleton(CreateTransactionBloc(getIt(), getIt()));
  getIt.registerSingleton(UpdateTransactionBloc(getIt(), getIt()));
  getIt.registerSingleton(LoginBloc());
}