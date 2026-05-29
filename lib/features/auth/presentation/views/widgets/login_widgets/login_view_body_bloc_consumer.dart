import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/functions/buildErrorWidget.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_view_body.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // 1. الوصول لخدمة الجلسة المحلية
          final sessionService = LocalSessionService.instance;

          // 2. حفظ بيانات المستخدم الفعلية في SharedPreferences
          // ده السطر اللي بيخلي isLoggedIn() في الـ main ترجع true دايماً
          await sessionService.saveSession(
            LocalUserSession(
              id: state.user.id.toString(),
              name: state.user.name ?? '',
              email: state.user.email ?? '',
              photoPath: null,
            ),
          );
          await sessionService.setRememberMe(state.rememberMe);

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginSuccessful.routeName,
              (route) => false,
            );
          }
        }

        // معالجة حالة الخطأ
        if (state is LoginError) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        // تمرير حالة التحميل لتعطيل الأزرار أثناء الريكويست
        return LoginViewBody(
          isLoading: state is LoginLoading,
        );
      },
    );
  }
}