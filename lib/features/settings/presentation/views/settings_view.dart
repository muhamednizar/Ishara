import 'package:flutter/material.dart';
import 'package:ishara/features/settings/presentation/views/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String routeName = 'settings_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsViewBody(),
    );
  }
}

