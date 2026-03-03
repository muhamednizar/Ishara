import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ishara/models/video_model.dart';

class ApiService {
  // الـ API Key اللي أنت بعته
  static const String _apiKey = 'AIzaSyBZaM4gmbdA1nwhLzc3uO_ynjAMRFt_jvI';
  
  // الـ Playlist ID بتاعك
  static const String _playlistId = 'PLPQXMMYIqXWK4qviwsiUM-JxlYkKtjrLa';

  static Future<List<VideoModel>> fetchVideos() async {
    final String url = 
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=20&playlistId=$_playlistId&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> items = data['items'];
        
        return items.map((item) => VideoModel.fromJson(item)).toList();
      } else {
        debugPrint("Error: ${response.body}"); // عشان لو في مشكلة تظهر في الـ Console
        throw Exception('فشل في جلب البيانات من يوتيوب');
      }
    } catch (e) {
      throw Exception('تأكد من اتصالك بالإنترنت: $e');
    }
  }
}