import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/services/auth_gate.dart';
import 'package:ishara/core/utils/injection_container.dart';
import 'package:ishara/core/widgets/more_Sentences.dart';

// Auth Imports
import 'package:ishara/features/auth/data/data_sources/auth_data_source.dart';
import 'package:ishara/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/views/forget_password_view.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/otp_view.dart';
import 'package:ishara/features/auth/presentation/views/sign_up_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/create_new_password.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';
import 'package:ishara/features/camera/presentation/manager/camera_cubit.dart';

// Camera Imports
import 'package:ishara/features/camera/presentation/views/camera_view.dart';

// Home Imports
import 'package:ishara/features/home/presentation/manager/home_cubit.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';
import 'package:ishara/features/home/presentation/views/widgets/fav_videos.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_details.dart';

import 'package:ishara/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ishara/features/settings/presentation/manager/profile_edit_cubit/profile_edit_cubit.dart';
import 'package:ishara/features/settings/presentation/views/widgets/change_language.dart';
import 'package:ishara/features/settings/presentation/views/widgets/edit_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/features/splash/presentation/views/splash_view.dart';

// --- Dependencies Injection ---

// All dependencies are registered in `injection_container.dart`

// --- Routes Configuration ---

Route<dynamic>? Function(RouteSettings settings) onGenerateRoute = (settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case HomeView.routeName:
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<HomeCubit>()..fetchAllVideos()),
            // 👇 مررنا الـ Instance الموحد للـ Camera
            BlocProvider.value(value: sl<CameraCubit>()),
          ],
          child: const HomeView(),
        ),
      );

    case VideoDetails.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider.value(
          value: sl<HomeCubit>(),
          child: const VideoDetails(),
        ),
      );

    case LoginView.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => LoginCubit(sl<AuthRepo>()),
          child: const LoginView(),
        ),
      );

    case SignUp.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SignUpCubit(sl<AuthRepo>()),
          child: const SignUp(),
        ),
      );

    case OtpView.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => OtpCubit(sl<AuthRepo>()),
          child: OtpView(
            userId: int.tryParse(args?['userId']?.toString() ?? '0') ?? 0,
            email: args?['email']?.toString() ?? 'Unknown',
          ),
        ),
      );

    case FavVideos.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider.value(
          value: sl<HomeCubit>(),
          child: const FavVideos(),
        ),
      );

    case LoginSuccessful.routeName:
      return MaterialPageRoute(builder: (context) => const LoginSuccessful());

    case EditProfile.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => ProfileEditCubit(),
          child: EditProfile(),
        ),
      );

    case ChangeLanguage.routeName:
      return MaterialPageRoute(
        builder: (context) => ChangeLanguage(),
      );

    case AuthGate.routeName:
      return MaterialPageRoute(builder: (context) => const AuthGate());

    case ForgetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => LoginCubit(sl<AuthRepo>()),
          child: const ForgetPasswordView(),
        ),
      );

    case CreateNewPassword.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => LoginCubit(sl<AuthRepo>()),
          child: CreateNewPassword(
            email: args?['email']?.toString() ?? '',
          ),
        ),
      );

    case CameraView.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: sl<CameraCubit>(),
          child: const CameraView(),
        ),
      );
      
      case MoreSentences.routeName:
      return MaterialPageRoute(
        builder:  (context) => const MoreSentences()
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('No Route Found'.tr())),
        ),
      );
  }
};
