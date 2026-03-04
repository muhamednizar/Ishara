import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/cubits/sign_up_cubit.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/build_or_widget.dart'; // تأكد من المسار


class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

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
                'Full Name',
                style: TextStyles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _fullNameController,
                hintText: 'Enter your full name',
                keyboardType: TextInputType.name,
              ),
              
              const SizedBox(height: 24),
          
              // ---  الإيميل ---
              Text(
                'Email address',
                style: TextStyles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 24),
          
              // ---  الباسورد ---
              Text(
                'Password',
                style: TextStyles.bold16,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'Password',
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
                            text: 'I agree to the ',
                            style: TextStyles.medium16,
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyles.medium16.copyWith(
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
                child: CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignUpCubit>().signUp(
                        _fullNameController.text,
                        _emailController.text,
                        _passwordController.text,
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
                  Text(
                    'Already have an account?',
                    style: TextStyles.medium16,
                  ),
                  TextButton(
                    onPressed: () {
                    Navigator.pushNamed(context, LoginView.routeName);
                    }, child: Text(
                      'Log In',
                      style: TextStyles.medium16.copyWith(
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