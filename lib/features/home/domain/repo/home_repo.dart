import 'package:dart_either/dart_either.dart';
import 'package:ishara/core/errors/failure.dart';
import 'package:ishara/features/home/data/models/video_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<VideoModel>>> getAllVideos();
  // التعديل هنا: غيرنا String لـ Failure
  Future<Either<Failure, void>> addVideoToFavorites(String videoTitle);
}