import 'package:flutter/material.dart';
import 'package:ishara/core/services/auth_gate.dart';
import 'package:ishara/core/services/local_auth_service.dart';
import 'package:ishara/features/settings/presentation/views/widgets/edit_profile.dart';
import 'package:ishara/features/settings/presentation/views/widgets/settings_options.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, EditProfile.routeName),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: SettingsOptions(icon: Icons.person, title: 'Profile')),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: SettingsOptions(icon: Icons.settings, title: 'Settings')),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: SettingsOptions(icon: Icons.help, title: 'Help')),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            await LocalAuthService().signOut();
            if (!context.mounted) return;
            Navigator.pushNamed(context, AuthGate.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: SettingsOptions(icon: Icons.logout, title: 'Logout')),
          ),
        ),
      ],
    );
  }
}

