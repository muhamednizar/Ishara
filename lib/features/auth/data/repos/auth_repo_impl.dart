import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:ishara/core/utils/local_storage_service.dart';
import 'package:ishara/features/auth/domain/entities/user_entity.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import '../data_sources/auth_data_source.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final LocalStorageService localStorageService;

  AuthRepoImpl(this.authRemoteDataSource, this.localStorageService);

  @override
  @override
  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await authRemoteDataSource.login(email: email, password: password);

      if (response['id'] == null &&
          (response['user'] == null || response['user']['id'] == null) &&
          response['tokens'] == null) {
        String errorMessage = "بيانات الدخول غير صحيحة";
        if (response.containsKey('detail'))
          errorMessage = response['detail'].toString();
        else if (response.containsKey('error'))
          errorMessage = response['error'].toString();
        return Left(errorMessage);
      }

      final userData = response['user'] ?? response;

      final user = UserModel.fromJson(userData);

      final accessToken = response['tokens']?['access'] ??
          response['token'] ??
          response['key'] ??
          '';
      if (accessToken.toString().isNotEmpty) {
        await localStorageService.saveToken(accessToken.toString());
      }

      return Right(user);
    } catch (e) {
      return Left("مشكلة في قراءة البيانات: $e");
    }
  }

  @override
  Future<Either<String, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.signUp(
          name: name, email: email, password: password);

      if (response['id'] == null &&
          (response['user'] == null || response['user']['id'] == null)) {
        String errorMessage = "الإيميل مستخدم بالفعل أو البيانات غير صحيحة";

        if (response.containsKey('email')) {
          if (response['email'] is List) {
            errorMessage = response['email'][0].toString();
          } else {
            errorMessage = response['email'].toString();
          }
        } else if (response.values.isNotEmpty &&
            response.values.first is List) {
          errorMessage = response.values.first[0].toString();
        } else if (response.containsKey('error')) {
          errorMessage = response['error'].toString();
        }

        return Left(errorMessage);
      }

      final user = UserModel.fromJson(response['user'] ?? response);

      final accessToken =
          response['tokens']?['access'] ?? response['token'] ?? '';
      if (accessToken.isNotEmpty) {
        await localStorageService.saveToken(accessToken);
      }

      return Right(user);
    } catch (e) {
      return Left("Registration Error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> confirmEmail({
    required int userId,
    required String otp,
  }) async {
    try {
      await authRemoteDataSource.confirmEmail(userId: userId, otp: otp);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resendOtp({
    required String email,
  }) async {
    try {
      await authRemoteDataSource.resendOtp(email: email);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> forgetPassword({required String email}) async {
    try {
      debugPrint('📧 forgetPassword called with email: $email');
      final response = await authRemoteDataSource.forgetPassword(email: email);

      debugPrint('📦 forgetPassword response: $response');

      if (response is Map<String, dynamic> && response['_isError'] == true) {
        final raw = response['data'];
        if (raw is Map<String, dynamic>) {
          // تحقق من وجود رسالة نجاح حتى لو كان الـ status code خطأ
          if (_isForgetPasswordSuccess(raw)) {
            debugPrint('✅ ForgetPassword success despite error status');
            return const Right(null);
          }
          final errorKey = _parseForgetPasswordError(raw);
          debugPrint('❌ ForgetPassword error: $errorKey');
          return Left(errorKey ?? "otp_send_failed");
        }
        return const Left("otp_send_failed");
      }

      if (response is Map<String, dynamic>) {
        if (_isForgetPasswordSuccess(response)) {
          debugPrint('✅ ForgetPassword success');
          return const Right(null);
        }
        final errorKey = _parseForgetPasswordError(response);
        if (errorKey != null) {
          debugPrint('❌ ForgetPassword error: $errorKey');
          return Left(errorKey);
        }
      }

      debugPrint('✅ ForgetPassword completed');
      return const Right(null);
    } catch (e) {
      debugPrint('⚠️ ForgetPassword exception: $e');
      return Left("otp_send_failed");
    }
  }

  bool _isForgetPasswordSuccess(Map<String, dynamic> response) {
    // تحقق من الرسائل التي تشير إلى النجاح
    final message = response['message'] ?? response['detail'] ?? '';
    if (message is String) {
      final lower = message.toLowerCase();
      if (lower.contains('activation code sent') ||
          lower.contains('sent to your email') ||
          lower.contains('check your email') ||
          lower.contains('otp sent') ||
          lower.contains('verification code')) {
        return true;
      }
    }
    return false;
  }

  String? _parseForgetPasswordError(Map<String, dynamic> response) {
    if (response.containsKey('success')) {
      if (response['success'] == false) {
        return _extractForgetPasswordKey(response);
      }
      return null;
    }

    if (response.containsKey('status')) {
      if (response['status'] == false) {
        return _extractForgetPasswordKey(response);
      }
      return null;
    }

    if (response.containsKey('error')) {
      return _extractForgetPasswordKey(response);
    }

    if (response.containsKey('email')) {
      final emailError = response['email'];
      if (emailError is List && emailError.isNotEmpty) {
        return _extractForgetPasswordKey(response);
      }
      if (emailError is String && emailError.isNotEmpty) {
        final lower = emailError.toLowerCase();
        if (lower.contains('not registered') ||
            lower.contains('not found') ||
            lower.contains('does not exist')) {
          return "email_not_registered";
        }
        if (lower.contains('error') ||
            lower.contains('fail') ||
            lower.contains('failed') ||
            lower.contains('invalid')) {
          return "otp_send_failed";
        }
        return emailError;
      }
    }

    final message =
        response['message'] ?? response['detail'] ?? response['error'];
    if (message is String) {
      final lower = message.toLowerCase();
      // تحقق من رسائل النجاح أولاً - إذا كانت رسالة نجاح، لا تعاملها كخطأ
      if (lower.contains('activation code sent') ||
          lower.contains('sent to your email') ||
          lower.contains('check your email') ||
          lower.contains('otp sent') ||
          lower.contains('verification code')) {
        return null; // رسالة نجاح، لا خطأ
      }
      if (lower.contains('not registered') ||
          lower.contains('not found') ||
          lower.contains('does not exist')) {
        return "email_not_registered";
      }
      if (lower.contains('error') ||
          lower.contains('fail') ||
          lower.contains('failed') ||
          lower.contains('invalid')) {
        return "otp_send_failed";
      }
      // فقط أرجع الرسالة إذا كانت واضحة أنها خطأ
      return null;
    }

    return null;
  }

  String _extractForgetPasswordKey(Map<String, dynamic> response) {
    final message =
        response['message'] ?? response['detail'] ?? response['error'];
    if (message is String) {
      final lower = message.toLowerCase();
      if (lower.contains('email') && lower.contains('exist'))
        return "email_not_registered";
      if (lower.contains('not registered') ||
          lower.contains('not found') ||
          lower.contains('does not exist')) return "email_not_registered";
      if (lower.contains('error') ||
          lower.contains('fail') ||
          lower.contains('failed') ||
          lower.contains('invalid')) return "otp_send_failed";
      return "otp_send_failed";
    }
    if (response.containsKey('email')) {
      final emailError = response['email'];
      if (emailError is List && emailError.isNotEmpty) {
        return emailError.first.toString();
      }
      if (emailError is String && emailError.isNotEmpty) {
        final lower = emailError.toLowerCase();
        if (lower.contains('not registered') ||
            lower.contains('not found') ||
            lower.contains('does not exist')) return "email_not_registered";
      }
    }
    return "otp_send_failed";
  }

  @override
  Future<Either<String, void>> resetPassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    try {
      debugPrint('🔄 Starting resetPassword for email: $email');
      await authRemoteDataSource.resetPassword(
          email: email, otp: otp, newPassword: newPassword);
      debugPrint('✅ resetPassword successful');
      return const Right(null);
    } catch (e) {
      debugPrint('❌ resetPassword error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      // استخراج رسالة الخطأ من الـ exception
      String errorMessage = _extractResetPasswordError(e);
      debugPrint('📌 Extracted error message: $errorMessage');
      return Left(errorMessage);
    }
  }

  String _extractResetPasswordError(dynamic error) {
    debugPrint('🔍 Extracting resetPassword error from: ${error.runtimeType}');
    
    // إذا كان DioException
    if (error is DioException && error.response != null) {
      debugPrint('📡 Response status: ${error.response!.statusCode}');
      debugPrint('📦 Response data: ${error.response!.data}');
      
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        // تحقق من الحقول الشائعة للأخطاء
        if (data.containsKey('otp')) {
          final otpError = data['otp'];
          if (otpError is List && otpError.isNotEmpty) {
            return otpError.first.toString();
          }
          return otpError.toString();
        }
        if (data.containsKey('password')) {
          final passwordError = data['password'];
          if (passwordError is List && passwordError.isNotEmpty) {
            return passwordError.first.toString();
          }
          return passwordError.toString();
        }
        if (data.containsKey('email')) {
          final emailError = data['email'];
          if (emailError is List && emailError.isNotEmpty) {
            return emailError.first.toString();
          }
          return emailError.toString();
        }
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        }
        if (data.containsKey('error')) {
          return data['error'].toString();
        }
      }
    }
    debugPrint('⚠️ Using default error message: reset_password_failed');
    return "reset_password_failed";
  }
}
