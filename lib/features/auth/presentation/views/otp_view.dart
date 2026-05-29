import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/auth/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:ishara/features/auth/presentation/manager/otp_cubit/otp_state.dart';
import 'package:ishara/features/home/presentation/views/home_view.dart';

class OtpView extends StatefulWidget {
  static const routeName = 'otp_view';
  final int userId;
  final String email;

  const OtpView({super.key, required this.userId, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Email'.tr()), centerTitle: true),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email Verified Successfully!'.tr()), backgroundColor: Colors.green),
            );
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          }
          if (state is OtpVerifyFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          if (state is OtpResendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('New OTP sent to your email'.tr()), backgroundColor: Colors.blue),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter the 4-digit code sent to'.tr(), style: Styles.medium16),
                Text(widget.email, style: Styles.bold16.copyWith(color: Colors.blue)),
                const SizedBox(height: 30),
                
                // مربعات الـ OTP
                PinCodeTextField(
                  appContext: context,
                  length: 4, // الباك إند بتاعك طالب 4 أرقام
                  keyboardType: TextInputType.number,
                  onChanged: (value) => otpCode = value,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    inactiveColor: Colors.grey,
                    activeColor: Colors.blue,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                state is OtpVerifyLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Verify'.tr(),
                        onPressed: () {
                          if (otpCode.length == 4) {
                            context.read<OtpCubit>().verifyOtp(
                                  userId: widget.userId,
                                  otp: otpCode,
                                );
                          }
                        },
                      ),
                
                const SizedBox(height: 20),
                
                // زرار إعادة الإرسال
                TextButton(
                  onPressed: state is OtpResendLoading
                      ? null
                      : () => context.read<OtpCubit>().resendOtp(email: widget.email),
                  child: Text('Resend Code'.tr()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}