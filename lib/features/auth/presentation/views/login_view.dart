import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_view_body.dart';

class LoginView extends StatelessWidget{
  LoginView({super.key});
  static const String routeName = 'login_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Log in'),
      body: LoginViewBody(),
    );
  }
}
