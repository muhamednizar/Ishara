import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/features/home/domain/repo/home_repo.dart';
import 'package:ishara/features/home/data/models/video_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  List<VideoModel> allVideosList = [];

  Future<void> fetchAllVideos() async {
    emit(GetVideosLoading());
    final result = await homeRepo.getAllVideos();
    
    result.fold(
      ifLeft: (failure) => emit(GetVideosError(errMessage: failure.message)),
      ifRight: (videos) {
        allVideosList = videos;
        emit(GetVideosSuccess(videos: allVideosList));
      },
    );
  }

  // التعديل هنا: لغينا السيرفر واعتمدنا على الـ Local State
  Future<void> toggleFavorite(VideoModel video) async {
    // 1. تحديث حالة الفيديو في اللستة الأساسية
    allVideosList = allVideosList.map((v) {
      if (v.id == video.id) {
        return v.copyWith(isFav: !v.isFav);
      }
      return v;
    }).toList();

    // 2. تحديث الشاشة فوراً
    emit(GetVideosSuccess(videos: List.from(allVideosList)));
    
    // 3. إرسال حالة النجاح عشان لو بتعرض SnackBar
    emit(AddFavoriteSuccess());
  }

  // دالة إضافية هتفيدك جداً في شاشة (FavVideos)
  List<VideoModel> get favoriteVideos {
    return allVideosList.where((video) => video.isFav).toList();
  }
}