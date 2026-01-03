import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/auth/presentation/views/sign_up_view.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/build_or_widget.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/login_successful.dart';
import 'package:ishara/features/auth/presentation/views/widgets/login_widgets/social_login_tile.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isChecked = false;
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
                onPressed: () {
                  Navigator.pushNamed(context, LoginSuccessful.routeName);
                },
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
                onTap: () {}
                ),
      
                const SizedBox(height: 16),
      
                CustomSocialLoginTile(
                title: 'Sign in with Facebook Account',
                image: 'assets/images/facebook_logo.png',
                onTap: () {}
                ),
      
                const SizedBox(height: 16),
      
                CustomSocialLoginTile(
                title: 'Sign in with Apple Account',
                  image: 'assets/images/apple_logo.png',
                onTap: () {}
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text('Don\'t have an account?', style: TextStyles.medium16,),
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, SignUp.routeName);
                  }, child: Text('Sign Up', style: TextStyles.medium16.copyWith(color: AppColors.primaryColor),)),
                  
                ],
                
                )
                ,const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
