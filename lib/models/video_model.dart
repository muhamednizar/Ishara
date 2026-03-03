class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;

  VideoModel({
    required this.id, 
    required this.title, 
    required this.thumbnailUrl
  });

  // الدالة دي بنستخدمها لما البيانات تيجي من الـ API (اليوتيوب)
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    // لو البيانات جاية من الذاكرة المحلية (Local Storage) مش من API اليوتيوب
    if (json.containsKey('local_id')) {
      return VideoModel(
        id: json['local_id'],
        title: json['local_title'],
        thumbnailUrl: json['local_thumb'],
      );
    }

    // هنا بنراعي شكل بيانات API اليوتيوب
    final snippet = json['snippet'] ?? {};
    final resourceId = snippet['resourceId'] ?? {};
    final thumbnails = snippet['thumbnails'] ?? {};

    return VideoModel(
      id: resourceId['videoId'] ?? '', 
      title: snippet['title'] ?? 'No Title',
      thumbnailUrl: thumbnails['high']?['url'] ?? thumbnails['default']?['url'] ?? '',
    );
  }

  // الدالة دي بنستخدمها عشان نحول الفيديو لـ "نص" يتخزن في الموبايل
  Map<String, dynamic> toJson() {
    return {
      'local_id': id,
      'local_title': title,
      'local_thumb': thumbnailUrl,
    };
  }
}