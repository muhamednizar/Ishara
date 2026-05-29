import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/utils/assets.dart';
import 'package:ishara/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  double signOffsetX = 500;
  double wordOffsetY = 200;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 70), () {
      if (mounted) setState(() => signOffsetX = 0);
    });
    Future.delayed(Duration(milliseconds: 1270), () {
      if (mounted) setState(() => wordOffsetY = 0);
    });
    executeNavigateToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SvgPicture.asset(AssetsData.splashLogo),
              SizedBox(width: 10),
            ],
          ),
          // الإشارة مع أنيميشن من اليمين
          AnimatedContainer(
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(signOffsetX, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AssetsData.signSplash),
                SizedBox(width: 70),
              ],
            ),
          ),
          Spacer(),
          // الجملة مع أنيميشن من تحت
          AnimatedContainer(
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, wordOffsetY, 0),
            child: Column(
              children: [
                SvgPicture.asset(AssetsData.wordSplash),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void executeNavigateToHome(BuildContext context) async {
  final session = LocalSessionService.instance;
  
  // هل دي أول مرة يفتح التطبيق؟
  bool firstTime = await session.isFirstTime();
  // هل هو مسجل دخول حالياً؟
  bool loggedIn = await session.isLoggedIn();
  // هل هو كان معلم على "Remember Me"؟
  bool rememberMe = await session.shouldRemember();

  Future.delayed(const Duration(milliseconds: 2472), () async {
    if (!context.mounted) return;

    if (firstTime) {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }
    // هنا بقى السر:
    // لو هو مسجل دخول (loggedIn) وكمان كان معلم على (rememberMe) يدخل عل طول
    else if (loggedIn && rememberMe) {
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    } 
    // لو مش معلم على Remember Me، بنمسح السشن ونوديه للوجن (كأنه لسه فاتح)
    else {
      await session.clearSession(); // امسح السشن القديمة لأنها "مؤقتة"
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    }
  });
}