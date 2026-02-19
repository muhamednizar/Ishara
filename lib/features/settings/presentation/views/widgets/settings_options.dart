import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';

class SettingsOptions extends StatelessWidget {
  SettingsOptions({super.key, required this.icon, required this.title});
  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColorLight, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 24, color: AppColors.primaryColor),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Icon(Icons.arrow_forward_ios, size: 24, color: AppColors.primaryColor),
    
        ],
      ),
    );
  }
}