abstract class OtpState {}

class OtpInitial extends OtpState {}

// 1. حالات تأكيد الكود (Verify)
class OtpVerifyLoading extends OtpState {}
class OtpVerifySuccess extends OtpState {}
class OtpVerifyFailure extends OtpState {
  final String message;
  OtpVerifyFailure(this.message);
}

// 2. حالات إعادة إرسال الكود (Resend)
class OtpResendLoading extends OtpState {}
class OtpResendSuccess extends OtpState {}
class OtpResendFailure extends OtpState {
  final String message;
  OtpResendFailure(this.message);
}