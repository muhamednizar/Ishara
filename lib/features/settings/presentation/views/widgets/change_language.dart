import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // 👈 لازم المكتبة دي
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});
  static const String routeName = 'change_language';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: true, context: context, title: 'Change Language'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          // الخيار الأول: العربية
          ListTile(
            title: const Text("العربية"),
            leading: const Icon(Icons.language),
            trailing: context.locale.languageCode == 'ar' 
                ? Icon(Icons.check, color: AppColors.primaryColor) 
                : null,
            onTap: () async {
              await context.setLocale(const Locale('ar', 'EG'));
            },
          ),
          
          const Divider(),
          
          // الخيار الثاني: الإنجليزية
          ListTile(
            title: const Text("English"),
            leading: const Icon(Icons.language),
            trailing: context.locale.languageCode == 'en' 
                ? Icon(Icons.check, color: AppColors.primaryColor) 
                : null,
            onTap: () async {
              await context.setLocale(const Locale('en', 'US'));
            },
          ),
        ],
      ),
    );
  }
}