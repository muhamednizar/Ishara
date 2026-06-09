import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
// تأكد من المسارات دي عندك
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart'; // تأكد من مسار شاشة اللوجين

class CreateNewPassword extends StatefulWidget {
  static const String routeName = 'create-new-password';
  final String email;

  const CreateNewPassword({super.key, required this.email});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Create Password'.tr(),
                style: Styles.bold16.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              Text(
                'Your new password must be unique from those previously used.'
                    .tr(),
                style: Styles.medium16.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),

              Text(
                'Verification Code'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: otpController,
                hintText: 'Enter 4-digit code'.tr(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              Text(
                'New Password'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: passwordController,
                hintText: 'Enter new password'.tr(),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              Text(
                'Confirm Password'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: confirmPasswordController,
                hintText: 'Re-enter new password'.tr(),
                obscureText: true,
              ),
              const SizedBox(height: 40),

              // <<< هنا ركبنا الـ BlocConsumer واللوجيك بتاع الزرار >>>
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Password changed successfully!'.tr()),
                          backgroundColor: Colors.green),
                    );
                    // نرجعه لشاشة اللوجين عشان يدخل بالباسوورد الجديد
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginView.routeName, (route) => false);
                  } else if (state is ResetPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.errMessage.tr()),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: state is ResetPasswordLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Reset Password'.tr(),
                            width: double.infinity,
                            height: 48,
                            onPressed: () {
                              debugPrint('🔐 Reset Password button pressed');
                              debugPrint('   Email: ${widget.email}');
                              debugPrint('   OTP: ${otpController.text}');
                              debugPrint('   New Password length: ${passwordController.text.length}');
                              
                              // 1. نتأكد إن الحقول مش فاضية والباسوورد متطابق
                              if (passwordController.text ==
                                      confirmPasswordController.text &&
                                  otpController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                debugPrint('✅ All validations passed');
                                // 2. نبعت الداتا للكيوبيت
                                context.read<LoginCubit>().resetPasswordWithOtp(
                                      email: widget
                                          .email, // بناخد الإيميل اللي جي من الشاشة اللي قبلها
                                      otp: otpController.text,
                                      newPassword: passwordController.text,
                                    );
                              } else {
                                debugPrint('❌ Validation failed');
                                debugPrint('   Passwords match: ${passwordController.text == confirmPasswordController.text}');
                                debugPrint('   OTP not empty: ${otpController.text.isNotEmpty}');
                                debugPrint('   Password not empty: ${passwordController.text.isNotEmpty}');
                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Make sure code is entered and passwords match'
                                              .tr()),
                                      backgroundColor: Colors.orange),
                                );
                              }
                            },
                          ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
