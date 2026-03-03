import 'package:flutter/material.dart';
import 'package:ishara/api_video/custom_appbar.dart';
import 'package:ishara/api_video/video_detaul_screen.dart';
import 'package:ishara/api_video/video_grid.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // استخدام الـ AppBar الموحد مع إظهار سهم الرجوع
      appBar: const CustomAppBar(
        title: 'Favorite Videos',
        showBackButton: true, 
      ),
      body: favoriteVideosList.isEmpty
          ? _buildEmptyState() // لو مفيش فيديوهات مفضلة
          : _buildFavoritesGrid(), // لو فيه فيديوهات يعرضها
    );
  }

  // ودجت تظهر لما القائمة تكون فاضية
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_outline, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            "No favorite videos yet",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // تصميم الـ Grid بنفس استايل الصفحة الأولى بالظبط
  Widget _buildFavoritesGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.3, 
        ),
        itemCount: favoriteVideosList.length,
          // favoriteVideosList
        itemBuilder: (context, index) {
                final video = favoriteVideosList[index];
                bool isFavorite = favoriteVideosList.any((v) => v.title == video.title);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. حاوية الفيديو (ثابتة فوق الاسم والنجمة)
                    Expanded(
        child: GestureDetector(
          onTap: () {
            // الانتقال لصفحة التفاصيل وتمرير الفيديو الذي تم الضغط عليه
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoDetailScreen(video: video),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF3B95D1), width: 2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                video.thumbnailUrl, 
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),


                    // 2. سطر البيانات (الاسم يمين والنجمة يسار)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // يوزعهم على الأطراف
                      crossAxisAlignment: CrossAxisAlignment.start, // يحاذي النجمة مع أول سطر في الاسم
                      children: [
                        // الاسم (أقصى اليمين)
                        Expanded(
                          child: Text(
                            video.title, 
                            maxLines: 2, // حد أقصى سطرين
                            overflow: TextOverflow.ellipsis, // نقط عند زيادة النص
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 13,
                            ),
                          ),
                        ),
                        
                        // مسافة صغيرة جداً لضمان عدم التلامس
                        const SizedBox(width: 4),

                        // النجمة (أقصى اليسار)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isFavorite) {
                                favoriteVideosList.removeWhere((v) => v.title == video.title);
                              } else {
                                favoriteVideosList.add(video);
                              }
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.orange : Colors.grey,
                            size: 22, // حجم متناسق مع الاسم
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
      ),
    );
  }
}