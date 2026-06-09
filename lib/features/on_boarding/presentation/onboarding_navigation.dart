import 'package:flutter/material.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';

/// ينهي الـ onboarding ولا يعرضه مرة تانية، ثم يفتح شاشة تسجيل الدخول.
Future<void> finishOnboarding(BuildContext context) async {
  await LocalSessionService.instance.setFirstTimeDone();
  if (!context.mounted) return;
  Navigator.pushNamedAndRemoveUntil(
    context,
    LoginView.routeName,
    (route) => false,
  );
}
