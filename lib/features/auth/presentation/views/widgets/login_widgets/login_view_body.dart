import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/cubits/login_cubit.dart';
import 'package:ishara/features/auth/presentation/views/sign_up_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/build_or_widget.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/social_login_tile.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColors.primaryColor,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        'Remember me',
                        style: TextStyles.medium16,
                      ),
                    ])
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyles.medium16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: CustomButton(
                text: 'Log in',
                onPressed: () => context.read<LoginCubit>().login(
                  _emailController.text.trim(),
                  _passwordController.text,
                ),
                width: 443,
                height: 48,
              ),
            ),
            const SizedBox(height: 16),
            OrDivider(),
            const SizedBox(height: 16),
            CustomSocialLoginTile(
                title: 'Sign in with Google Account',
                image: 'assets/images/google_logo.png',
                onTap: () {}),
            const SizedBox(height: 16),
            CustomSocialLoginTile(
                title: 'Sign in with Facebook Account',
                image: 'assets/images/facebook_logo.png',
                onTap: () {}),
            const SizedBox(height: 16),
            CustomSocialLoginTile(
                title: 'Sign in with Apple Account',
                image: 'assets/images/apple_logo.png',
                onTap: () {}),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyles.medium16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyles.medium16
                          .copyWith(color: AppColors.primaryColor),
                    )),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }


}
