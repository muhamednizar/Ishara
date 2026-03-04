import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfileName(String name) async {
    emit(EditProfileNameLoading());
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      emit(EditProfileNameSuccess());
    } on FirebaseAuthException catch (e) {
      emit(EditProfileNameFailure(error: e.message ?? 'An error occurred'));
    } catch (e) {
      emit(EditProfileNameFailure(error: e.toString()));
    }
  }
}