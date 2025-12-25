import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ishara/core/utils/app_images.dart';
import 'package:ishara/core/utils/app_text_style.dart';
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
  @override
  void initState() {
    super.initState();
    successNavigateToHome(context);
  } @override
  void dispose() {
    super.dispose();
    successNavigateToHome(context);
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
            Text('Login Successful', style: TextStyles.semiBold24, textAlign: TextAlign.center,),
            const SizedBox(height: 16),
            Text('Welcome back to the app', style: TextStyles.medium16,),
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
void successNavigateToHome(BuildContext context) {
  Future.delayed(Duration(milliseconds: 1300), () {
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  });
}