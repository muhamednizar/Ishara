import 'package:ishara/features/home/data/models/video_model.dart'; // تأكد من مسار الموديل

abstract class HomeState {}

class HomeInitial extends HomeState {}

// =========================================
// 1. حالات جلب الفيديوهات للصفحة الرئيسية
// =========================================

class GetVideosLoading extends HomeState {}

class GetVideosSuccess extends HomeState {
  final List<VideoModel> videos;

  GetVideosSuccess({required this.videos});
}

class GetVideosError extends HomeState {
  final String errMessage;

  GetVideosError({required this.errMessage});
}

// =========================================
// 2. حالات إضافة فيديو للمفضلة
// =========================================

class AddFavoriteLoading extends HomeState {}

class AddFavoriteSuccess extends HomeState {
  // ممكن تباصي رسالة نجاح هنا لو عايز تعرضها في SnackBar
}

class AddFavoriteError extends HomeState {
  final String errMessage;

  AddFavoriteError({required this.errMessage});
}