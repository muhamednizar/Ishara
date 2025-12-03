import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed, required this.width,  this.height});
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),)
      );
  }
}