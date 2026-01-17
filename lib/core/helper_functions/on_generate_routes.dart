import 'package:flutter/material.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/sign_up_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';
import 'package:ishara/features/home/presentation/views/widgets/fav_videos.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_details.dart';
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
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => LoginView());
    case SignUp.routeName:
    return MaterialPageRoute(builder: (context) => SignUp());
    case LoginSuccessful.routeName:
    return MaterialPageRoute(builder: (context) => LoginSuccessful());
    case FavVideos.routeName:
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const FavVideos(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
    case VideoDetails.routeName:
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const VideoDetails(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
    default:
      return null;
  }
};