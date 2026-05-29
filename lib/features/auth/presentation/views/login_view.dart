import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/injection_container.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_view_body_bloc_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Log in'.tr()),
      body: const LoginViewBodyBlocConsumer(),
    );
  }
}