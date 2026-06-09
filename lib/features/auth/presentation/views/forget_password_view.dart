import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:ishara/features/auth/presentation/views/widgets/create_new_password.dart';

class ForgetPasswordView extends StatefulWidget {
  static const String routeName = 'forget-password';
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('Forget Password'.tr(), style: Styles.bold16.copyWith(fontSize: 28)),
            const SizedBox(height: 12),
            Text(
              'Don\'t worry! it occurs. Please enter the email address linked with your account.'.tr(),
              style: Styles.medium16.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Text('Email address'.tr(), style: Styles.bold16),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: emailController,
              hintText: 'Enter your email'.tr(),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Activation code sent to your email'.tr()), backgroundColor: Colors.green),
                  );
                  // الذهاب للشاشة التانية وإرسال الإيميل
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    try {
                      debugPrint('ForgetPasswordSuccess: navigating to CreateNewPassword');
                      Navigator.of(context).pushNamed(
                        CreateNewPassword.routeName,
                        arguments: {'email': emailController.text},
                      );
                    } catch (e, stack) {
                      debugPrint('ForgetPassword navigation error: $e');
                      debugPrint('$stack');
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Navigation failed. Please try again.'.tr()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  });
                } else if (state is ForgetPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errMessage.tr()), backgroundColor: Colors.red),
                  );
                }
              },
              builder: (context, state) {
                return Center(
                  child: state is ForgetPasswordLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Next'.tr(),
                          width: double.infinity,
                          height: 48,
                          onPressed: () {
                            if (emailController.text.isNotEmpty) {
                              context.read<LoginCubit>().sendForgetPasswordOtp(
                                email: emailController.text,
                              );
                            }
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}