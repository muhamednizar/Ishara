import 'package:ishara/core/utils/api_service.dart';
import 'package:ishara/features/home/data/models/video_model.dart';

class HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSource(this._apiService);

  // // 1. جلب الفيديوهات من سيرفر دجانجو الخاص بك
  // Future<List<VideoModel>> getAllVideos() async {
  //   try {
  //     final response = await _apiService.get(endpoint: 'v1/Videos/Get_All_Videos/');
  //     final data = response['data'];
  //     final List<dynamic> videosJson = switch (data) {
  //       {'videos': final v} when v is List => v,
  //       List<dynamic> v => v,
  //       _ => const <dynamic>[],
  //     };
  //     return videosJson.map((json) => VideoModel.fromJson(json)).toList();
  //   } catch (e) {
  //     rethrow; 
  //   }
  // }

  // 2. دمجنا منطق YoutubeApiService هنا بس باستخدام ApiService بتاعنا
  Future<List<VideoModel>> getYoutubeVideos() async {
    const String apiKey = 'AIzaSyBZaM4gmbdA1nwhLzc3uO_ynjAMRFt_jvI';
    const String playlistId = 'PLPQXMMYIqXWK4qviwsiUM-JxlYkKtjrLa';
    
    final String url = 
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=20&playlistId=$playlistId&key=$apiKey';

    try {
      final response = await _apiService.getCustomUrl(url);
      
      final List<dynamic> items = response['items'] ?? [];
      
      return items.map((json) => VideoModel.fromYoutubeJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // 3. إضافة فيديو للمفضلة
  Future<void> addVideoToFavorites(String videoTitle) async {
    try {
      await _apiService.post(
        endpoint: 'v1/Videos/add-fav-video-to-user/',
        data: {'video_title': videoTitle},
      );
    } catch (e) {
      rethrow;
    }
  }
}