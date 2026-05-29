class VideoModel {
  final int id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  bool isFav; // تم إزالة final للسماح بالتحديث المحلي
  final bool isYoutube;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.isFav,
    this.isYoutube = false,
  });

  // دالة تحديث الحالة في الـ Bloc
  VideoModel copyWith({bool? isFav}) {
    return VideoModel(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      isFav: isFav ?? this.isFav,
      isYoutube: isYoutube,
    );
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['video_file'] ?? '',
      thumbnailUrl: json['thumbnail'] ?? '',
      isFav: json['is_fav'] ?? false,
      isYoutube: false,
    );
  }

  factory VideoModel.fromYoutubeJson(Map<String, dynamic> json) {
    final snippet = json['snippet'] ?? {};
    final thumbnails = snippet['thumbnails'] ?? {};
    final resourceId = snippet['resourceId'] ?? {};

    String thumbUrl = thumbnails['maxres']?['url'] ?? thumbnails['high']?['url'] ?? thumbnails['medium']?['url'] ?? '';

    return VideoModel(
      id: json['id']?.hashCode ?? 0,
      title: snippet['title'] ?? 'فيديو يوتيوب',
      description: snippet['description'] ?? '',
      videoUrl: resourceId['videoId'] ?? '',
      thumbnailUrl: thumbUrl,
      isFav: false,
      isYoutube: true,
    );
  }
}