import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/on_boarding/presentation/onboarding_navigation.dart';

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
                  child: GestureDetector(
                    onTap: () => finishOnboarding(context),
                    child: Text('Skip', style: Styles.semiBold24),
                  )),
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
            title.tr(),
            style: Styles.semiBold24,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description.tr(),
              style: Styles.medium16,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          CustomButton(
            text: buttonText.tr(),
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
