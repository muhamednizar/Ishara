import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed,  this.width = 343,  this.height = 48});
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,style: TextStyles.semiBold16.copyWith(color: Colors.white)),)
      );
  }
}