import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_images.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            AppColors.primaryColor,
            Color(0xff0D47A1)
          ],
        ),
      ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.splashLogo),
            SizedBox(width: 10),
          ],  
          
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(AppImages.signSplash),
            SizedBox(width: 70),
          ],
        ),
        Spacer(),
        SvgPicture.asset(AppImages.wordSplash),
        (SizedBox(height: 20)),
      ],
    ),
  );
  }
}