import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/build_error_bar.dart';
import 'package:ishara/features/auth/presentation/cubits/login_cubit.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return  LoginViewBody();
      },
      );
  }
}
