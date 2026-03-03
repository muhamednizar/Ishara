import 'package:flutter/material.dart';
import 'package:ishara/api_video/video_detaul_screen.dart';
import 'package:ishara/models/video_model.dart';
import 'package:ishara/services/api_service.dart';
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';

List<VideoModel> favoriteVideosList = [];

class VideoGridScreen extends StatefulWidget {
  const VideoGridScreen({super.key});

  @override
  State<VideoGridScreen> createState() => _VideoGridScreenState();
}

class _VideoGridScreenState extends State<VideoGridScreen> {
  late Future<List<VideoModel>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = ApiService.fetchVideos();
    loadFavorites(); 
  }

  // Future<void> _handleRefresh() async {
  //   setState(() { _videosFuture = ApiService.fetchVideos(); });
  //   await _videosFuture;
  // }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(favoriteVideosList.map((v) => v.toJson()).toList());
    await prefs.setString('favorite_videos', encodedData);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('favorite_videos');
    if (jsonString != null) {
      List<dynamic> decodedData = jsonDecode(jsonString);
      setState(() {
        favoriteVideosList = decodedData.map((item) => VideoModel.fromJson(item)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoModel>>(
      future: _videosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text("حدث خطأ: ${snapshot.error}"));
        }

        final videos = snapshot.data ?? [];

        // --- التغيير الأساسي هنا: استخدمنا SizedBox مع ListView بالعرض ---
        return SizedBox(
          height: 220, // الارتفاع الكلي للجزء بتاع الفيديوهات
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // السكرول بالعرض
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              bool isFavorite = favoriteVideosList.any((v) => v.title == video.title);

              return Container(
                width: 300, // عرض الكارت الواحد
                margin: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // صورة الفيديو
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoDetailScreen(video: video)),
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
                    // العنوان والنجمة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            video.title,
                            maxLines: 1, // سطر واحد عشان المساحة بالعرض محدودة
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (isFavorite) {
                                favoriteVideosList.removeWhere((v) => v.title == video.title);
                              } else {
                                favoriteVideosList.insert(0, video);
                              }
                            });
                            await saveFavorites();
                          },
                          child: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.orange : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}