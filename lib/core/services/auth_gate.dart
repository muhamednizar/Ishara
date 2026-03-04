import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';

class AuthGate extends StatelessWidget {
  static const String routeName = 'auth_gate';
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoginSuccessful();
          } else {
            return LoginView();
          }
        },
      ),
    );
  }
}
