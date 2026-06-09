import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/more_Sentences.dart';
import 'package:ishara/features/home/presentation/views/widgets/sentence_sign.dart';

void showSignBottomSheet(BuildContext context, SignPhrase phrase) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // عشان تتحكم في الارتفاع
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      // بنحدد ارتفاع نسبي للشاشة عشان الموبايلات المختلفة
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [
          // خط صغير فوق عشان يبان إنه BottomSheet (Handle)
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColorLight.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, MoreSentences.routeName);           
              },
            child: Text('More Sentences', style: Styles.medium24),
          ),
          // مسافة بين الزرار والعنوان
          const SizedBox(width: 20),
          // العنوان
          Text(
            phrase.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // الـ GIF/Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: phrase.gifUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                // جوه الـ BottomSheet (جزء الـ CachedNetworkImage)
                errorWidget: (context, url, error) {
                  print("GIF Error: $error");

                  return Center(
                    child: Text(
                      "Error: $error",
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
