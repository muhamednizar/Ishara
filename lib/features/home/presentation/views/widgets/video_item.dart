import 'package:flutter/material.dart';
import 'package:ishara/features/home/data/models/video_model.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_details.dart';

class VideoItemWidget extends StatelessWidget {
  final VideoModel video;
  const VideoItemWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, VideoDetails.routeName, arguments: video);
      },
      child: Container(
        width: 180, 
        // 👇 ده الحل: مسافة 8 بيكسل يمين وشمال كل كارت عشان ميلزقوش في بعض
        margin: const EdgeInsets.symmetric(horizontal: 8), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    video.thumbnailUrl.isNotEmpty 
                        ? video.thumbnailUrl 
                        : "https://via.placeholder.com/343x220",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              video.title,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}