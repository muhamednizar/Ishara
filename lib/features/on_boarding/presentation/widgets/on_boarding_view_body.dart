import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/features/on_boarding/presentation/widgets/on_boarding_page_view_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingViewBody extends StatefulWidget {
  OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  int activeIndex = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    controller.addListener(() {
      setState(() {
        activeIndex = controller.page?.round() ?? 0;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: OnBoardingPageViewBody(controller: controller)),
        AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: 2,
            effect: WormEffect(
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.secondaryColor,
            ),


          ),
          SizedBox(height: 20),
        ],
      ),
      
    );
  }
}
