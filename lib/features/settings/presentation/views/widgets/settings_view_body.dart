import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/local_storage_service.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/settings/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:ishara/features/settings/presentation/manager/theme_cubit/theme_state.dart';
import 'package:ishara/features/settings/presentation/views/widgets/change_language.dart';
import 'package:ishara/features/settings/presentation/views/widgets/edit_profile.dart';
import 'package:ishara/features/settings/presentation/views/widgets/settings_options.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(context.locale.toString()),
      mainAxisAlignment: MainAxisAlignment.center, // هيخلي العناصر في نص الشاشة بالضبط
      children: [
        // 1. Profile
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, EditProfile.routeName),
          child: _buildItem(context, Icons.person, 'Profile'.tr()),
        ),
        
        // 2. Language
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, ChangeLanguage.routeName),
          child: _buildItem(context, Icons.language, 'Language'.tr()),
        ),

        // 3. Theme
        BlocBuilder<ThemeCubit, dynamic>(
          builder: (context, state) {
            bool isDark = false;
            if (state is ThemeChanged) {
              isDark = state.isDarkMode;
            }
            return GestureDetector(
              onTap: () => context.read<ThemeCubit>().toggleTheme(),
              child: _buildItem(
                context,
                isDark ? Icons.dark_mode : Icons.light_mode,
                isDark ? 'Dark Mode'.tr() : 'Light Mode'.tr(),
              ),
            );
          },
        ),

        // 4. About Us
        _buildItem(context, Icons.info, 'About us'.tr()),

        // 5. Logout
        GestureDetector(
          onTap: () async {
            const storage = FlutterSecureStorage();
            final localStorageService = LocalStorageService(storage);
            await localStorageService.deleteToken();
            await LocalSessionService.instance.setRememberMe(false);
            await LocalSessionService.instance.signOut();
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);
          },
          child: _buildItem(context, Icons.logout, 'Logout'.tr()),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: SettingsOptions(icon: icon, title: title),
      ),
    );
  }
}