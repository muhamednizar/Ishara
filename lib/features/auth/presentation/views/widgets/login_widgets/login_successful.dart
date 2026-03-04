import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_images.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';

class LoginSuccessful extends StatefulWidget {
   LoginSuccessful({super.key});
  static const String routeName = 'login_successful';
  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {
  String userName = FirebaseAuth.instance.currentUser?.displayName ??
      FirebaseAuth.instance.currentUser?.email ??
      '';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Successful', isBack: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(child: SvgPicture.asset(AppImages.loginSuccess)),
            Text.rich(
              TextSpan(
                text: 'Welcome ',
                style: TextStyles.semiBold16,
                children: [
                  TextSpan(
                    text: userName,
                    style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
              style: TextStyles.semiBold24,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Login Successful',
              style: TextStyles.medium16,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Go to Home',
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
