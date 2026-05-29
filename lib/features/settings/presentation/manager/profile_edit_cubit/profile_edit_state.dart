part of 'profile_edit_cubit.dart';

@immutable
sealed class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}

final class ProfileEditNameLoading extends ProfileEditState {}

final class ProfileEditNameSuccess extends ProfileEditState {}

final class ProfileEditNameFailure extends ProfileEditState {
  final String error;
  ProfileEditNameFailure({required this.error});
}

final class ProfileEditPictureLoading extends ProfileEditState {}

final class ProfileEditPictureSuccess extends ProfileEditState {}

final class ProfileEditPictureFailure extends ProfileEditState {
  final String error;
  ProfileEditPictureFailure({required this.error});
}
