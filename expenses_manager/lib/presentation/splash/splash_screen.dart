import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<User?> check() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    // todo comprobar las cosas necesarias y actuar en consecuencia
    Future.delayed(const Duration(seconds: 1), () async {
      final user = await check();
      if(user == null){
        Navigator.pushReplacementNamed(context, 'login');
      }
      else{
        Navigator.pushReplacementNamed(context, 'root');
      }
    });
    return Center(
      child: CircularProgressIndicator.adaptive()
    );
  }
}