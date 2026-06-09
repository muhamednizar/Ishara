import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/core/services/local_session_service.dart'; // الخدمة اللي في الـ main
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ishara/features/auth/presentation/views/sign_up_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/build_or_widget.dart';
import 'package:ishara/features/auth/presentation/views/forget_password_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/social_login_tile.dart';

class LoginViewBody extends StatefulWidget {
  final bool isLoading;
  const LoginViewBody({super.key, this.isLoading = false});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final saved = await LocalSessionService.instance.getRememberMe();
    if (mounted) setState(() => isChecked = saved);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text('Email address'.tr(), style: Styles.bold16),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email'.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Text('Password'.tr(), style: Styles.bold16),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'Password'.tr(),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text('Remember me'.tr(), style: Styles.medium16),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ForgetPasswordView.routeName);
                    },
                    child: Text(
                      'Forgot password?'.tr(),
                      style: Styles.medium16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: widget.isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Log in'.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginCubit>().loginUser(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  rememberMe: isChecked,
                                );
                          }
                        },
                        width: 443,
                        height: 48,
                      ),
              ),
              const SizedBox(height: 16),
              const OrDivider(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'.tr(), style: Styles.medium16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    child: Text(
                      'Sign Up'.tr(),
                      style: Styles.medium16.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomSocialLoginTile(
                title: 'Continue with Google'.tr(),
                image: 'assets/images/google_logo.png',
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
