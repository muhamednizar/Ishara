import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ishara/core/helper_functions/on_generate_routes.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/features/splash/presentation/views/splash_view.dart';
import 'package:ishara/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IsharaApp());
}
class IsharaApp extends StatelessWidget {
  const IsharaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          centerTitle: true,
          
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}