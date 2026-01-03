import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/presentation/views/widgets/sign_up_widgets/sign_view_body.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  static const String routeName = 'sign_up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Sign Up'),
      body: SignUpViewBody(),
    );
  }
}