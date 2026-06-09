import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // بنحقن (Inject) الـ Repo هنا عشان الكيوبيت يقدر يكلم السيرفر
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  // دالة اللوجين اللي هتتربط بزرار "تسجيل الدخول"
  Future<void> loginUser({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    // 1. الشاشة بتدخل في حالة تحميل
    emit(LoginLoading());

    // 2. بننده على الـ Repo
    final result = await authRepo.login(email: email, password: password);

    // 3. بنهندل النتيجة (Fold بتاعة حزمة Dartz بتفصل النجاح عن الفشل)
    result.fold(
      ifLeft: (failure) {
        // لو السيرفر رجع إن الحساب محتاج تفعيل (تقدر تظبط رسالة الخطأ دي بناءً على رد السيرفر الفعلي)
        if (failure.contains('تفعيل')) {
          // هتحتاج تستخرج الـ userId من الإيرور لو السيرفر بيبعته، أو تخليه يبعت كود جديد
          emit(LoginRequiresVerification(message: failure, userId: 0));
        } else {
          // أي خطأ تاني (باسوورد غلط، مفيش نت، الخ)
          emit(LoginError(failure));
        }
      },
      ifRight: (user) => emit(LoginSuccess(user, rememberMe: rememberMe)),
    );
  }

  // 1. دالة إرسال الـ OTP للإيميل
  Future<void> sendForgetPasswordOtp({required String email}) async {
    debugPrint('📧 sendForgetPasswordOtp called with email: $email');
    
    emit(ForgetPasswordLoading());

    // تأكد إن اسم authRepo مطابق للي عندك في الكيوبيت
    final result = await authRepo.forgetPassword(email: email);

    result.fold(
      ifLeft: (failure) {
        debugPrint('❌ ForgetPassword failed: $failure');
        emit(ForgetPasswordFailure(errMessage: failure));
      },
      ifRight: (success) {
        debugPrint('✅ ForgetPassword success - OTP sent');
        emit(ForgetPasswordSuccess());
      },
    );
  }

  // 2. دالة التأكيد وتغيير الباسوورد
  Future<void> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    debugPrint('🔐 resetPasswordWithOtp called with:');
    debugPrint('   Email: $email');
    debugPrint('   OTP: $otp');
    debugPrint('   Password length: ${newPassword.length}');
    
    emit(ResetPasswordLoading());

    // <<< الغلطة كانت هنا: تم التعديل عشان ينده الدالة الصح ويبعت الداتا كلها >>>
    final result = await authRepo.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    result.fold(
      ifLeft: (failure) {
        debugPrint('❌ ResetPassword failed: $failure');
        emit(ResetPasswordFailure(errMessage: failure));
      },
      ifRight: (success) {
        debugPrint('✅ ResetPassword success');
        emit(ResetPasswordSuccess());
      },
    );
  }
}
