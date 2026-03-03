import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_images.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';
import 'package:ishara/features/on_boarding/presentation/views/widgets/page_view_item.dart';

class OnBoardingPageViewBody extends StatelessWidget {
  OnBoardingPageViewBody({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        PageViewItem(
          
          
          image: AppImages.OnBoardingImage1,
          title: 'Communication Made Simple',
          description: 'Express yourself clearly, without speaking.',
          buttonText: 'Next',
          onPressed: () {
            controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        ),
        PageViewItem(
          isVisible: false,
          image: AppImages.OnBoardingImage2,
          title: 'Sign Language, Anywhere',
          description: 'Use ready-made signs and symbols to communicate instantly.',
          buttonText: 'Start',
          onPressed: () {
            Navigator.pushNamed(context, LoginView.routeName);
            
          }
        ),
      ],
    );
  }
}

