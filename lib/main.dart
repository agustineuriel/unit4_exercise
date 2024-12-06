import 'package:flutter/material.dart';
import 'package:unit4_exercise/features/login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        );
  }
}
