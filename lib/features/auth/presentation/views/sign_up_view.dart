import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/presentation/views/widgets/sign_up_widgets/signup_view_body_bloc_consumer.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  static const String routeName = 'sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Sign Up'.tr()),
      body: const SignUpViewBodyBlocConsumer(),
    );
  }
}