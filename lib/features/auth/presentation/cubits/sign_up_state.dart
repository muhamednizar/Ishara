part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserModel user;
  SignUpSuccess(this.user);
}

final class SignUpFailure extends SignUpState {
  final String message;
  SignUpFailure(this.message);
}
