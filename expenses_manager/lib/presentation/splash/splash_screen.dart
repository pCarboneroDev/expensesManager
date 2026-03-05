import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // todo comprobar las cosas necesarias y actuar en consecuencia
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, 'login');
    });
    return Center(
      child: CircularProgressIndicator.adaptive()
    );
  }
}