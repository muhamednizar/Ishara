import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/data/repo/auth_repo_impl.dart';
import 'package:ishara/features/auth/presentation/cubits/login_cubit.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_view_body_bloc_consumer.dart';
import 'package:ishara/core/services/firbase_auth_services.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Log in'),
      body: BlocProvider(
          create: (_) => LoginCubit(
              authRepo:
                  AuthRepoImpl(firebaseAuthServices: FirebaseAuthServices())),
          child: const LoginViewBodyBlocConsumer()),
    );
  }
}
