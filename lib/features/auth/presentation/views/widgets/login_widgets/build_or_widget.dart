import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_text_style.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: AppColors.primaryColor,
        )),
        const SizedBox(width: 20),
        Text('Or Log in with',
            style: TextStyles.semiBold16
                .copyWith(color: Colors.black)),
        const SizedBox(width: 20),
        Expanded(
            child: Divider(
          color: AppColors.primaryColor,
        )),
      ],
    );
  }
}
