import 'package:ishara/features/auth/domain/entities/user_entity.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

// حالة التحميل (عشان زرار إنشاء الحساب يلف)
class SignUpLoading extends SignUpState {}

// حالة النجاح (بترجع بيانات اليوزر)
class SignUpSuccess extends SignUpState {
  final UserEntity user;

  SignUpSuccess(this.user);
}

// حالة الفشل (بترجع رسالة الخطأ زي إيميل موجود قبل كده أو باسوورد ضعيف)
class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);
}