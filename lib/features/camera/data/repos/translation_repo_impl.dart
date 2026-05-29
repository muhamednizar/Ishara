import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dart_either/dart_either.dart';
import 'package:ishara/core/utils/api_service.dart';

class TranslationRepoImpl {
  final ApiService _apiService;
  TranslationRepoImpl(this._apiService);

  /// 1. ترجمة الحروف العربية (CNN Model)
Future<Either<String, String?>> translateLetter(String imagePath) async {
    try {
      print("DEBUG: Sending image to YOLO Letters... Path: $imagePath");

      FormData formData = FormData.fromMap({
        'picture': await MultipartFile.fromFile(imagePath, filename: 'frame.jpg'),
      });

      final rawResponse = await _apiService.postForm(
        endpoint: 'v1/YOLO/hand-tracking/', // 
        data: formData,
      );

      Map<String, dynamic> response;
      if (rawResponse is Map<String, dynamic>) {
        response = rawResponse;
      } else if (rawResponse is String) {
        response = jsonDecode(rawResponse.trim()) as Map<String, dynamic>;
      } else {
        response = (rawResponse as dynamic).data as Map<String, dynamic>;
      }

      if (response['status'] == 'success') {
        final data = response['data'] as Map<String, dynamic>;
        
        final arabicLetter = data['arabic_letter'];
        
        if (arabicLetter != null && arabicLetter.toString().trim() != 'null') {
          return Right(arabicLetter.toString());
        }
        
        return const Right(null);
      } else {
        return const Left('فشل التعرف على الحرف من السيرفر');
      }
    } catch (e) {
      print("DEBUG: YOLO Letters Error: ${e.toString()}");
      return Left(e.toString());
    }
  }
  /// 2. ترجمة الأرقام من 1 إلى 10 (MediaPipe Rule-based)
  Future<Either<String, int?>> translateNumber(String imagePath) async {
    try {
      print("DEBUG: Sending image to MediaPipe Numbers... Path: $imagePath");

      FormData formData = FormData.fromMap({
        'picture': await MultipartFile.fromFile(imagePath, filename: 'frame.jpg'),
      });

      final rawResponse = await _apiService.postForm(
        endpoint: 'v1/Mediapipe/hand-tracking/',
        data: formData,
      );

      Map<String, dynamic> response;
      if (rawResponse is Map<String, dynamic>) {
        response = rawResponse;
      } else if (rawResponse is String) {
        response = jsonDecode(rawResponse.trim()) as Map<String, dynamic>;
      } else {
        response = (rawResponse as dynamic).data as Map<String, dynamic>;
      }

      if (response['status'] == 'success') {
        final data = response['data'] as Map<String, dynamic>;
        bool handDetected = data['hand_detected'] ?? false;
        
        if (handDetected) {
          return Right(data['number']);
        }
        return const Right(null);
      } else {
        return const Left('فشل التعرف على الرقم من السيرفر');
      }
    } catch (e) {
      print("DEBUG: MediaPipe Numbers Error: ${e.toString()}");
      return Left(e.toString());
    }
  }

  /// 3. تحويل النص المترجم إلى صوت مسموع (gTTS)
  Future<Either<String, String>> textToSpeech(String text) async {
    try {
      print("DEBUG: Sending text to gTTS... Text: $text");
      
      final rawResponse = await _apiService.post(
        endpoint: 'v1/GTTS/text-to-speech/',
        data: {"text": text, "language": "ar"},
      );

      Map<String, dynamic> response;
      if (rawResponse is Map<String, dynamic>) {
        response = rawResponse;
      } else if (rawResponse is String) {
        response = jsonDecode(rawResponse.trim()) as Map<String, dynamic>;
      } else {
        response = (rawResponse as dynamic).data as Map<String, dynamic>;
      }

      if (response['Status:'] == 'Success' || response['status'] == 'success') {
        String? audioUrl = response['URL'] ?? response['url'];
        if (audioUrl != null) {
          return Right(audioUrl);
        }
      }
      return const Left('فشل تحويل النص إلى صوت مسموع');
    } catch (e) {
      print("DEBUG: gTTS Error: ${e.toString()}");
      return Left(e.toString());
    }
  }
}