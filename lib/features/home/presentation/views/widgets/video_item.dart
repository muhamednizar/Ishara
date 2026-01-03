// --- VideoItemWidget يظل كما هو ---
import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';

class VideoItemWidget extends StatelessWidget {
  const VideoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. قللنا العرض ليكون مناسباً للسكرول العرضي
      width: 160,
      margin: const EdgeInsets.only(right: 12), // مسافة بين الكروت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)), // إطار خفيف
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2. الجزء العلوي: الصورة
          Expanded(
            flex: 3, // تأخذ 3 أجزاء من المساحة
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12), // تدوير من الأعلى فقط
                ),
                image: const DecorationImage(
                  // صورة مؤقتة
                  image: NetworkImage("https://via.placeholder.com/160x100"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow,
                      color: Colors.white, size: 30),
                ),
              ),
            ),
          ),

          // 3. الجزء السفلي: النصوص
          Expanded(
            flex: 2, // يأخذ جزئين من المساحة
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "درس الحروف الأبجدية",
                    maxLines: 2, // سطرين كحد أقصى
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.semiBold24
                        .copyWith(fontSize: 14, color: Colors.black87),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "10:00 دقيقة",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Spacer(),
                      const Icon(Icons.star_outline_sharp, size: 17, color: Colors.yellow),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
