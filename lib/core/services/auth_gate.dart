import 'package:flutter/material.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';

class AuthGate extends StatelessWidget {
  static const String routeName = 'auth_gate';
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(

        stream: LocalSessionService.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final loggedIn = snapshot.data ?? false;
          if (loggedIn) {
            return const LoginSuccessful();
          }
          return const LoginView();
        },
      ),
    );
  }
}
