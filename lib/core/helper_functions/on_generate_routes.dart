import 'package:flutter/material.dart';
import 'package:ishara/features/home/home_view.dart';
import 'package:ishara/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ishara/features/splash/presentation/views/splash_view.dart';

Route<dynamic>? Function(RouteSettings settings) onGenerateRoute = (settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => HomeView());
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
      case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => OnBoardingView());
    default:
  }
};