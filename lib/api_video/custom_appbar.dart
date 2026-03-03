import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // هل يظهر سهم الرجوع؟
  final Widget? trailing; // لو عايز تضيف حاجة على اليمين (مثل النجمة)

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true, // الافتراضي إنه بيظهر
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF3B95D1), // اللون الأزرق اللي في التصميم
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50), // البوردر ريديوس من جانب واحد
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // زرار الرجوع (لو showBackButton بـ true)
              if (showBackButton)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )
              else
                const SizedBox(
                  width: 40,
                ), // مساحة بديلة لو مفيش سهم عشان العنوان يفضل في النص
              // العنوان في المنتصف
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // الجزء اللي على اليمين (لو بعت نجمة مثلاً هتظهر هنا)
              trailing ?? const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // زودنا الارتفاع عشان شكل التصميم
}
