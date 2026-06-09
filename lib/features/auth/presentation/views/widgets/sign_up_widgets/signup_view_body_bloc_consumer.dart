import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/functions/buildErrorWidget.dart';
import 'package:ishara/features/auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/sign_up_cubit/sign_up_state.dart';
import 'package:ishara/features/auth/presentation/manager/otp_cubit/otp_cubit.dart'; 
import 'package:ishara/features/auth/presentation/views/otp_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/sign_up_widgets/sign_view_body.dart';
import 'package:ishara/features/auth/data/repos/auth_repo_impl.dart'; 
import 'package:ishara/core/utils/api_service.dart';
import 'package:ishara/core/utils/local_storage_service.dart';
import 'package:ishara/features/auth/data/data_sources/auth_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // 1. رسالة نجاح في سناكس بار
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account created! Please check your email for the OTP.'.tr()),
              backgroundColor: Colors.green,
            ),
          );

          // 2. النقل المباشر مع الـ Provider (الحل النهائي للشاشة الحمراء)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => OtpCubit(
                  AuthRepoImpl(
                    AuthRemoteDataSource(ApiService(Dio(), LocalStorageService(const FlutterSecureStorage()))),
                    LocalStorageService(const FlutterSecureStorage()),
                  ),
                ),
                child: OtpView(
                  // استخدام ?? 0 عشان نمنع الشاشة السوداء (Null Error)
                  userId: state.user.id ?? 0,
                  email: state.user.email,
                ),
              ),
            ),
          );
        }

        if (state is SignUpError) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return SignUpViewBody(
          isLoading: state is SignUpLoading,
        );
      },
    );
  }
}