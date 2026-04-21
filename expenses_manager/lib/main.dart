import 'package:expenses_manager/di/dependendy_injection.dart';
import 'package:expenses_manager/firebase_options.dart';
import 'package:expenses_manager/presentation/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/create_transaction_screen.dart';
import 'package:expenses_manager/presentation/home/bloc/home_bloc.dart';
import 'package:expenses_manager/presentation/insights/bloc/insights_bloc.dart';
import 'package:expenses_manager/presentation/login/bloc/login_bloc.dart';
import 'package:expenses_manager/presentation/login/ui/screens/login_screen.dart';
import 'package:expenses_manager/presentation/login/ui/screens/register_screen.dart';
import 'package:expenses_manager/presentation/splash/splash_screen.dart';
import 'package:expenses_manager/presentation/transactions/bloc/transaction_bloc.dart';
import 'package:expenses_manager/presentation/transactions/ui/transactions_screen.dart';
import 'package:expenses_manager/presentation/root.dart';
import 'package:expenses_manager/presentation/update_transaction/bloc/update_transaction_bloc.dart';
import 'package:expenses_manager/presentation/update_transaction/ui/update_transaction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initGetIt();

  // final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  // final themeJson = jsonDecode(themeStr);
  // final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<TransactionBloc>()),
        BlocProvider(create: (context) => getIt<CreateTransactionBloc>()),
        BlocProvider(create: (context) => getIt<UpdateTransactionBloc>()),
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<InsightsBloc>())
      ], 
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  //final ThemeData theme;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData.dark(),
      routes: {
        'root': (context) => Root(),
        'transactions': (context) => TransactionsScreen(),
        'create_transaction': (context) => CreateTransactionScreen(),
        'update_transaction': (context) => UpdateTransactionScreen(),
        'splash': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen()
      },
      initialRoute: 'splash'
    );
  }
}