import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<User?> check() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<Database> openDatabaseFromAssets() async {
    // Get the temporary directory (cache)
    final directory = await getTemporaryDirectory();
    final path = join(directory.path, 'myDB.db');

    // Check if the database file exists
    final exists = await File(path).exists();

    if (!exists) {
      // Copy from assets
      ByteData data = await rootBundle.load('assets/db/myDB.db');
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    return await openDatabase(path);
  }

  @override
  Widget build(BuildContext context) {
    // todo comprobar las cosas necesarias y actuar en consecuencia
    Future.delayed(const Duration(seconds: 1), () async {
      final user = await check();
      final db = await openDatabase("assets/db/mi_app.db");
      print(db.path);

      if (user == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'root');
      }
    });
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
