import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/utils/assets.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';

class LoginSuccessful extends StatefulWidget {
  const LoginSuccessful({super.key});
  static const String routeName = 'login_successful';

  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    Future.delayed(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    });
  }

  Future<void> _loadUserName() async {
    final session = await LocalSessionService.instance.readSession();
    if (!mounted) return;
    setState(() {
      userName = session?.name.isNotEmpty == true
          ? session!.name
          : (session?.email ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Successful'.tr(), isBack: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(child: SvgPicture.asset(AssetsData.loginSuccess)),
            Text.rich(
              TextSpan(
                text: 'welcome'.tr(),
                style: Styles.semiBold16,
                children: [
                  TextSpan(
                    text: ' $userName',
                    style: Styles.semiBold16
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
              style: Styles.semiBold24,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Login Successful'.tr(),
              style: Styles.medium16,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Go to Home'.tr(),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
