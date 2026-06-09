import 'package:ishara/features/auth/domain/entities/user_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

// حالة التحميل (عشان تظهر CircularProgressIndicator في الزرار)
class LoginLoading extends LoginState {}

// حالة النجاح (بترجع بيانات اليوزر عشان لو حابب تعرض اسمه أو صورته)
class LoginSuccess extends LoginState {
  final UserEntity user;
  final bool rememberMe;

  LoginSuccess(this.user, {this.rememberMe = false});
}

// حالة الفشل (بترجع رسالة الخطأ عشان تعرضها في SnackBar)
class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

// (اختياري بس احترافي) حالة إن الإيميل مش متفعل عشان تنقله لشاشة الـ OTP
class LoginRequiresVerification extends LoginState {
  final String message;
  final int userId;

  LoginRequiresVerification({required this.message, required this.userId});
}

// حالات إرسال كود الـ OTP
class ForgetPasswordLoading extends LoginState {}

class ForgetPasswordSuccess extends LoginState {}

class ForgetPasswordFailure extends LoginState {
  final String errMessage;
  ForgetPasswordFailure({required this.errMessage});
}

// حالات تأكيد الكود وتغيير الباسوورد
class ResetPasswordLoading extends LoginState {}

class ResetPasswordSuccess extends LoginState {}

class ResetPasswordFailure extends LoginState {
  final String errMessage;
  ResetPasswordFailure({required this.errMessage});
}