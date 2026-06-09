import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo authRepo;

  OtpCubit(this.authRepo) : super(OtpInitial());

  // 1. دالة تأكيد الكود
  Future<void> verifyOtp({required int userId, required String otp}) async {
    emit(OtpVerifyLoading());

    final result = await authRepo.confirmEmail(userId: userId, otp: otp);

    result.fold(
      ifLeft:   (error) => emit(OtpVerifyFailure(error)),
      ifRight: (_) => emit(OtpVerifySuccess()),
    );
  }

  // 2. دالة إعادة إرسال الكود
  Future<void> resendOtp({required String email}) async {
    emit(OtpResendLoading());

    final result = await authRepo.resendOtp(email: email);

    result.fold(
      ifLeft: (error) => emit(OtpResendFailure(error)),
      ifRight: (_) => emit(OtpResendSuccess()),
    );
  }
}