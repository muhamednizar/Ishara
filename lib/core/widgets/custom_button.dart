import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed,  this.width = 343,  this.height = 48, this.enabled = true});
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: enabled ? AppColors.primaryColor : AppColors.secondaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: enabled ? onPressed : null ,
        child: Text(text,style: Styles.semiBold16.copyWith(color: Colors.white)),)
      );
  }
}