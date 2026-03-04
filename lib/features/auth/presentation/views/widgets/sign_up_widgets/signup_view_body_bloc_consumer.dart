import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/build_error_bar.dart';
import 'package:ishara/features/auth/presentation/cubits/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/views/widgets/sign_up_widgets/sign_view_body.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess){
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        }
        if(state is SignUpFailure){
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return SignUpViewBody();
      },
    );
  }
}