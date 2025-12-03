import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hintText, this.suffixIcon, this.obscureText = false, this.keyboardType, this.onSaved});
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        // Email validation
        if (keyboardType == TextInputType.emailAddress) {
          if (!RegExp(r'^.+@.+\..+$').hasMatch(value)) {
            return 'البريد الإلكتروني غير صحيح';
          }
        }
        return null;
      },


      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // hintStyle: TextStyles.bold16.copyWith(color: AppColors.hintColor),
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        hintText: hintText,
        suffixIcon: suffixIcon,
        
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFE6E9EA)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFE6E9EA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFE6E9EA)),
        ),
        
      ),
    );
    
  }
}