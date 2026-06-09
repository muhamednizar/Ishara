import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/app_router.dart';
import 'package:ishara/core/utils/injection_container.dart' as di;
import 'package:ishara/core/utils/local_storage_service.dart';
import 'package:ishara/core/theme/app_theme.dart';
import 'package:ishara/features/settings/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:ishara/features/settings/presentation/manager/theme_cubit/theme_state.dart';
import 'package:ishara/features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();

  final bool loggedIn = await LocalSessionService.instance.isLoggedIn();
  final themeCubit = ThemeCubit(di.sl<LocalStorageService>());
  await themeCubit.loadThemePreference();

  // تغليف التطبيق بـ EasyLocalization
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations', // مسار ملفات الترجمة
      fallbackLocale: const Locale('en', 'US'),
      child: BlocProvider.value(
        value: themeCubit,
        child: IsharaApp(isLoggedIn: loggedIn),
      ),
    ),
  );
}

class IsharaApp extends StatelessWidget {
  final bool isLoggedIn;
  const IsharaApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeCubit = context.read<ThemeCubit>();
        final isDarkMode = themeCubit.isDarkMode;

        return MaterialApp(
          // 👈 إضافات للترجمة و الـ RTL
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: SplashView.routeName,
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}
