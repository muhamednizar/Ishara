import 'package:flutter/material.dart';
import 'package:ishara/api_video/custom_appbar.dart';
import 'package:ishara/models/video_model.dart';
import 'package:pod_player/pod_player.dart';

// قائمة عالمية لتخزين آخر الفيديوهات التي تم فتحها
List<VideoModel> recentlyViewedList = [];

class VideoDetailScreen extends StatefulWidget {
  final VideoModel video;

  const VideoDetailScreen({super.key, required this.video});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();

    // إعداد المشغل باستخدام رابط يوتيوب
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://www.youtube.com/watch?v=${widget.video.id}',
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        forcedVideoFocus: true,
      ),
    )..initialise();

    // إضافة الفيديو الحالي لقائمة "آخر المشاهدات" ومنع التكرار
    if (!recentlyViewedList.any((v) => v.id == widget.video.id)) {
      recentlyViewedList.insert(0, widget.video);
    }
  }

  @override
  void dispose() {
    controller.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // الـ AppBar الأزرق مع سهم الرجوع
      appBar: const CustomAppBar(
        title: 'Videos',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. عرض الفيديو الأساسي (المشغل الجديد)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFF3B95D1), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: PodVideoPlayer(
                    controller: controller,
                    frameAspectRatio: 16 / 9, // الحفاظ على أبعاد الفيديو
                  ),
                ),
              ),
            ),

            // اسم الفيديو تحت المشغل
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.video.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            // 2. قسم "آخر المشاهدات" (Recently Viewed)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recently Viewed",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16, 
                  color: Colors.grey
                ),
              ),
            ),

            // قائمة الفيديوهات التي تمت مشاهدتها مؤخراً
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemCount: recentlyViewedList.length,
                itemBuilder: (context, index) {
                  final v = recentlyViewedList[index];
                  return _buildHistoryCard(v);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم الكارت الصغير الخاص بآخر المشاهدات
  Widget _buildHistoryCard(VideoModel v) {
    return GestureDetector(
      onTap: () {
        // إعادة فتح الصفحة بالفيديو المختار من القائمة بالأسفل
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailScreen(video: v),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  v.thumbnailUrl, 
                  fit: BoxFit.cover, 
                  width: double.infinity
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            v.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          // عرض أيقونة الساعة وكلمة ثابتة للوقت
          // const Row(
          //   children: [
          //     Icon(Icons.access_time, size: 14, color: Colors.grey),
          //     SizedBox(width: 4),
          //     Text(
          //       "10:00 minutes", 
          //       style: TextStyle(fontSize: 11, color: Colors.grey)
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}