import 'package:flutter/material.dart';
import 'package:ishara/features/splash/splash_view.dart';

void main() {
  runApp(const IsharaApp());
}
class IsharaApp extends StatelessWidget {
  const IsharaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),

    );
  }
}