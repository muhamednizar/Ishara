import 'package:dart_either/dart_either.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  // 1. تسجيل الدخول
  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  });

  // 2. إنشاء حساب
  Future<Either<String, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });

  // 3. تأكيد الإيميل بالكود
  Future<Either<String, void>> confirmEmail({
    required int userId,
    required String otp,
  });

  // 4. إعادة إرسال الكود
  Future<Either<String, void>> resendOtp({
    required String email,
  });

  // 5. نسيت كلمة المرور (إرسال كود الـ OTP)
  Future<Either<String, void>> forgetPassword({
    required String email,
  });

  // 6. تأكيد كود الـ OTP وتغيير كلمة المرور
  Future<Either<String, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
