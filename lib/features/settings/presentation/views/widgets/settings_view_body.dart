  import 'package:flutter/material.dart';
import 'package:ishara/features/settings/presentation/views/widgets/settings_options.dart';

class SettingsViewBody extends StatelessWidget {
  SettingsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: SettingsOptions(icon: Icons.person, title: 'Profile')),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: SettingsOptions(icon: Icons.logout, title: 'Logout')),
        ),
      ],
    );
  }
}

