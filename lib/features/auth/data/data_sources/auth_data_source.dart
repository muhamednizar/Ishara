import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:ishara/core/utils/api_service.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: 'user/login/',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: 'users/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'username': email.split('@')[0],
        },
      );
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // دالة مساعدة عشان نعرف السيرفر باعت إيه في الـ 400 Bad Request
  void _handleError(dynamic e) {
    if (e is DioException) {
      print("!!!!!!!!!!!!!!!! ERROR FROM SERVER !!!!!!!!!!!!!!!!");
      print("Status Code: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}"); // دي اللي فيها الحل
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  Future<Map<String, dynamic>> confirmEmail({
    required int userId,
    required String otp,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: 'user/confirm-email/',
        data: {
          'user_id': userId,
          'otp': int.parse(otp),
        },
      );
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: 'user/resend-otp/',
        data: {
          'email': email,
        },
      );
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

// 1. دالة طلب الـ OTP
  Future<dynamic> forgetPassword({required String email}) async {
    try {
      debugPrint('📤 Calling API forgetPassword endpoint with email: $email');
      final response = await _apiService.post(
        endpoint: 'user/forgot-password/',
        data: {'email': email.trim()},
        returnErrorData: true,
      );
      debugPrint('📥 forgetPassword API response: $response');
      return response;
    } catch (e) {
      debugPrint('⚠️ forgetPassword API exception: $e');
      rethrow;
    }
  }

  // 2. دالة تأكيد الـ OTP وتغيير الباسوورد
  Future<void> resetPassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    try {
      debugPrint('📤 Calling API resetPassword endpoint');
      debugPrint('   Email: $email, OTP: $otp, Password length: ${newPassword.length}');
      
      // محاولات متعددة مع أسماء حقول مختلفة
      final attempts = [
        {'password': newPassword, 'password_confirmation': newPassword},
        {'password': newPassword, 'confirm_password': newPassword},
        {'password': newPassword, 'password_confirm': newPassword},
        {'new_password': newPassword, 'new_password_confirmation': newPassword},
        {'new_password': newPassword, 'confirm_password': newPassword},
        {'password': newPassword, 'repassword': newPassword},
      ];

      DioException? lastError;
      
      for (int i = 0; i < attempts.length; i++) {
        try {
          final data = {
            'email': email,
            'otp': otp,
            ...attempts[i],
          };
          debugPrint('📨 Attempt ${i + 1} with data keys: ${data.keys.toList()}');
          
          final response = await _apiService.post(
            endpoint: 'user/reset-password/',
            data: data,
            returnErrorData: false,
          );
          
          debugPrint('✅ Success! resetPassword API response: $response');
          return;
        } on DioException catch (e) {
          lastError = e;
          debugPrint('❌ Attempt ${i + 1} failed: ${e.response?.data}');
          if (i < attempts.length - 1) {
            continue;
          } else {
            rethrow;
          }
        } catch (e) {
          debugPrint('⚠️ Attempt ${i + 1} error: $e');
          rethrow;
        }
      }
    } catch (e) {
      debugPrint('⚠️ resetPassword API error: $e');
      _handleError(e);
      rethrow;
    }
  }
}
