import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/functions/buildErrorWidget.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/sign_up_cubit/sign_up_state.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/build_or_widget.dart';

class SignUpViewBody extends StatefulWidget {
  // ضفنا المتغير ده عشان يستقبل حالة التحميل من الـ BlocConsumer اللي بره
  final bool isLoading; 
  
  const SignUpViewBody({super.key, this.isLoading = false});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  bool isTermsAccepted = false; 
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              
              // --- الاسم الكامل ---
              Text(
                'Full Name'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _fullNameController,
                hintText: 'Enter your full name'.tr(),
                keyboardType: TextInputType.name,
              ),
              
              const SizedBox(height: 24),
          
              // ---  الإيميل ---
              Text(
                'Email address'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email'.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 24),
          
              // ---  الباسورد ---
              Text(
                'Password'.tr(),
                style: Styles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'Password'.tr(),
                obscureText: true,
              ),
              
              const SizedBox(height: 16),
          
              // ---   الشروط والأحكام ---
              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = !isTermsAccepted;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppColors.primaryColor,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded( 
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree to the '.tr(),
                            style: Styles.medium16,
                          ),
                          TextSpan(
                            text: 'Terms & Conditions'.tr(),
                            style: Styles.medium16.copyWith(
                              color: AppColors.primaryColor, // تلوين الرابط
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 24),
          
              // --- زر إنشاء الحساب ---
              Center(
                // استخدمنا المتغير اللي استقبلناه من فوق بدل state is
                child: widget.isLoading 
                    ? const CircularProgressIndicator() 
                    : CustomButton( 
                        text: 'Create Account'.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (!isTermsAccepted) {
                              buildErrorBar(context, 'Please agree to the Terms & Conditions'.tr());
                              return;
                            }
                            context.read<SignUpCubit>().signUpUser( 
                              name: _fullNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        width: 443,
                        height: 48,
                      ),
              ),

              const SizedBox(height: 16),
              const SizedBox(height: 16),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?'.tr(),
                    style: Styles.medium16,
                  ),
                  TextButton(
                    onPressed: () {
                    Navigator.pushNamed(context, LoginView.routeName);
                    }, child: Text(
                      'Log In'.tr(),
                      style: Styles.medium16.copyWith(
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24), 
            ],
          ),
        ),
      ),
    );
  }
}