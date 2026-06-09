import 'package:expenses_manager/presentation/splash/bloc/splash_bloc.dart';
import 'package:expenses_manager/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    context.read<SplashBloc>().add(SyncEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.uiState.status == UIStatus.success) {
            Navigator.pushReplacementNamed(context, 'root');
          }
        },
        builder: (context, state) {
          final status = <UIStatus, Widget>{
            UIStatus.loading: Center(child: CircularProgressIndicator()),
            UIStatus.success: Container(),
            UIStatus.error: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48),
                SizedBox(height: 16),
                Text(state.uiState.errorMessage, style: TextStyle(color: Colors.red))
              ],
            )
          };
          return status[state.uiState.status] ?? Container();
        },
      ),
    );
  }
}
