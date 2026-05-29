import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';

class CustomSocialLoginTile extends StatelessWidget {
  const CustomSocialLoginTile({super.key, required this.title, required this.image, required this.onTap});
  final String title;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      title: Center(child: Text(title,style: Styles.semiBold16.copyWith(color: Colors.black),)),
      leading: Image.asset(image),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        
        side:  BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.4),
        ),  
      ),
      onTap: onTap,
      
    );
  }
}