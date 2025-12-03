import 'package:flutter/material.dart';
import 'package:ishara/core/helper_functions/on_generate_routes.dart';
import 'package:ishara/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const IsharaApp());
}
class IsharaApp extends StatelessWidget {
  const IsharaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}