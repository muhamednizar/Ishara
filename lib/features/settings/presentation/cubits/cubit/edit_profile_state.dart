part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class EditProfileNameLoading extends EditProfileState {}
class EditProfileNameSuccess extends EditProfileState {}
class EditProfileNameFailure extends EditProfileState {
  final String error;
  EditProfileNameFailure({required this.error});
}
