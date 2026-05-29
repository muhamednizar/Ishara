import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_bottom_sheet.dart';

// 2. الموديل (تأكد إنه هو اللي بتستخدمه)
class SignPhrase {
  final String title;
  final String imagePath; // الصورة اللي هتظهر في السلايدر
  final String gifUrl;    // الـ GIF اللي هيظهر في الـ BottomSheet

  SignPhrase({required this.title, required this.imagePath, required this.gifUrl});
}

class SentenceSign extends StatelessWidget {
  // بنمرر القائمة للـ Widget عشان يبقى ديناميكي
  final List<SignPhrase> phrases;

  const SentenceSign({super.key, required this.phrases});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: CarouselSlider.builder(
        itemCount: phrases.length,
        options: CarouselOptions(
          height: 150,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          viewportFraction: 0.85, 
          enlargeCenterPage: true, 
        ),
        itemBuilder: (context, index, realIndex) {
          final item = phrases[index];
          return GestureDetector(
            onTap: () {
              showSignBottomSheet(context, item);
            },
            child: _buildCarouselItem(item.imagePath),
          );
        },
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}