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
      return await _apiService.post(
        endpoint: 'user/forgot-password/', 
        data: {'email': email.trim()},
        returnErrorData: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  // 2. دالة تأكيد الـ OTP وتغيير الباسوورد
  Future<void> resetPassword({
    required String email, 
    required String otp, 
    required String newPassword
  }) async {
    try {
      await _apiService.post(
        endpoint: 'user/reset-password/', 
        data: {
          'email': email,
          'otp': otp,
          'password': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  } }