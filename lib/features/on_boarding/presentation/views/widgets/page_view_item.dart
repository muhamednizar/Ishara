import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/auth/presentation/views/login_view.dart';

class PageViewItem extends StatelessWidget {
  PageViewItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onPressed,
    this.isVisible = true,
  });
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                  visible: isVisible,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: GestureDetector(onTap: () {
                    Navigator.pushNamed(context, LoginView.routeName);
                  }, child: Text('Skip', style: TextStyles.semiBold24))),
            ],
          ),
          const SizedBox(height: 25),
          Image.asset(
            image,
            width: 350,
            height: 350,
          ),
          const SizedBox(height: 37),
          Text(
            title,
            style: TextStyles.semiBold24,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: TextStyles.medium16,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          CustomButton(
            text: buttonText,
            onPressed: onPressed ?? () {},
            width: 343,
            height: 48,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
