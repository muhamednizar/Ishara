import 'package:dart_either/dart_either.dart';
import 'package:ishara/features/auth/domain/entities/user_entity.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import '../data_sources/auth_data_source.dart';
import '../models/user_model.dart';
import 'package:ishara/core/utils/local_storage_service.dart';

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
      final response = await authRemoteDataSource.login(email: email, password: password);
      

      if (response['id'] == null && (response['user'] == null || response['user']['id'] == null) && response['tokens'] == null) {
         String errorMessage = "بيانات الدخول غير صحيحة";
         if (response.containsKey('detail')) errorMessage = response['detail'].toString();
         else if (response.containsKey('error')) errorMessage = response['error'].toString();
         return Left(errorMessage);
      }

      final userData = response['user'] ?? response;
      
      final user = UserModel.fromJson(userData);

      final accessToken = response['tokens']?['access'] ?? response['token'] ?? response['key'] ?? '';
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
      final response = await authRemoteDataSource.signUp(name: name, email: email, password: password);
      
      if (response['id'] == null && (response['user'] == null || response['user']['id'] == null)) {
        
        String errorMessage = "الإيميل مستخدم بالفعل أو البيانات غير صحيحة";
        
        if (response.containsKey('email')) {
           if (response['email'] is List) {
             errorMessage = response['email'][0].toString();
           } else {
             errorMessage = response['email'].toString();
           }
        } else if (response.values.isNotEmpty && response.values.first is List) {
          errorMessage = response.values.first[0].toString();
        } else if (response.containsKey('error')) {
          errorMessage = response['error'].toString();
        }
        
        return Left(errorMessage); 
      }

      final user = UserModel.fromJson(response['user'] ?? response);
      
      final accessToken = response['tokens']?['access'] ?? response['token'] ?? '';
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
      final response = await authRemoteDataSource.forgetPassword(email: email);

      if (response is Map<String, dynamic> && response['_isError'] == true) {
        final raw = response['data'];
        if (raw is Map<String, dynamic>) {
          final errorKey = _parseForgetPasswordError(raw);
          return Left(errorKey ?? "otp_send_failed");
        }
        return const Left("otp_send_failed");
      }

      if (response is Map<String, dynamic>) {
        final errorKey = _parseForgetPasswordError(response);
        if (errorKey != null) return Left(errorKey);
      }

      return const Right(null);
    } catch (e) {
      return Left("otp_send_failed");
    }
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
        if (lower.contains('not registered') || lower.contains('not found') || lower.contains('does not exist')) {
          return "email_not_registered";
        }
        if (lower.contains('error') || lower.contains('fail') || lower.contains('failed') || lower.contains('invalid')) {
          return "otp_send_failed";
        }
        return emailError;
      }
    }

    final message = response['message'] ?? response['detail'] ?? response['error'];
    if (message is String) {
      final lower = message.toLowerCase();
      if (lower.contains('not registered') || lower.contains('not found') || lower.contains('does not exist')) {
        return "email_not_registered";
      }
      if (lower.contains('error') || lower.contains('fail') || lower.contains('failed') || lower.contains('invalid')) {
        return "otp_send_failed";
      }
      return message;
    }

    return null;
  }

  String _extractForgetPasswordKey(Map<String, dynamic> response) {
    final message = response['message'] ?? response['detail'] ?? response['error'];
    if (message is String) {
      final lower = message.toLowerCase();
      if (lower.contains('email') && lower.contains('exist')) return "email_not_registered";
      if (lower.contains('not registered') || lower.contains('not found') || lower.contains('does not exist')) return "email_not_registered";
      if (lower.contains('error') || lower.contains('fail') || lower.contains('failed') || lower.contains('invalid')) return "otp_send_failed";
      return "otp_send_failed";
    }
    if (response.containsKey('email')) {
      final emailError = response['email'];
      if (emailError is List && emailError.isNotEmpty) {
        return emailError.first.toString();
      }
      if (emailError is String && emailError.isNotEmpty) {
        final lower = emailError.toLowerCase();
        if (lower.contains('not registered') || lower.contains('not found') || lower.contains('does not exist')) return "email_not_registered";
      }
    }
    return "otp_send_failed";
  }

  @override
  Future<Either<String, void>> resetPassword({
    required String email, 
    required String otp, 
    required String newPassword
  }) async {
    try {
      await authRemoteDataSource.resetPassword(email: email, otp: otp, newPassword: newPassword);
      return const Right(null);
    } catch (e) {
      return Left("reset_password_failed");
    }
  }
}