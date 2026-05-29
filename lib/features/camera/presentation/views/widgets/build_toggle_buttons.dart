import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/utils/styles.dart';

class BuildToggleButtons extends StatefulWidget {
  // ضفنا الدالة دي عشان نبلغ الشاشة الأب بالتغيير
  final Function(bool isLetters) onToggle;

  const BuildToggleButtons({super.key, required this.onToggle});

  @override
  State<BuildToggleButtons> createState() => _BuildToggleButtonsState();
}

class _BuildToggleButtonsState extends State<BuildToggleButtons> {
  bool isLetters = true; // الحالة المبدئية

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // زرار الحروف
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isLetters
                ? AppColors.primaryColor
                : AppColors.primaryColorLight.withOpacity(0.15),
            elevation: isLetters ? 4 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            setState(() => isLetters = true);
            widget.onToggle(true); // بنبلغ الشاشة إننا رجعنا للحروف
          },
          child: Text('Letters'.tr(),
              style: Styles.semiBold16.copyWith(
                  color: isLetters ? Colors.white : AppColors.primaryColor)),
        ),
        const SizedBox(width: 10),
        // زرار الأرقام
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: !isLetters
                ? AppColors.primaryColor
                : AppColors.primaryColorLight.withOpacity(0.15),
            elevation: !isLetters ? 4 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            setState(() => isLetters = false);
            widget.onToggle(false); // بنبلغ الشاشة إننا قلبنا أرقام
          },
          child: Text('Numbers'.tr(),
              style: Styles.semiBold16.copyWith(
                  color: !isLetters ? Colors.white : AppColors.primaryColor)),
        ),
      ],
    );
  }
}
