import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/services/firbase_auth_services.dart';
import 'package:ishara/core/widgets/custom_app_bar.dart';
import 'package:ishara/features/auth/data/repo/auth_repo_impl.dart';
import 'package:ishara/features/auth/presentation/cubits/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/views/widgets/sign_up_widgets/signup_view_body_bloc_consumer.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  static const String routeName = 'sign_up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, text: 'Sign Up'),
      body: BlocProvider(
          create: (_) => SignUpCubit(
              authRepo:
                  AuthRepoImpl(firebaseAuthServices: FirebaseAuthServices())),
          child: SignUpViewBodyBlocConsumer()),
    );
  }
}
