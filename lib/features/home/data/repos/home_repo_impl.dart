import 'package:dart_either/dart_either.dart';
import 'package:ishara/core/errors/failure.dart';
import 'package:ishara/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ishara/features/home/data/models/video_model.dart';
import 'package:ishara/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<VideoModel>>> getAllVideos() async {
    try {
      final List<VideoModel> videos = await homeRemoteDataSource.getYoutubeVideos();
      return Right(videos);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addVideoToFavorites(String videoTitle) async {
    try {
      // بنبعث video_title (صغير) عشان الـ 400 تختفي
      await homeRemoteDataSource.addVideoToFavorites(videoTitle);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}