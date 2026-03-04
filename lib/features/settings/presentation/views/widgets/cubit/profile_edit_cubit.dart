import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(ProfileEditInitial());
  Future<void> editProfileName(String name) async {
    emit(ProfileEditNameLoading());
    try{
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      emit(ProfileEditNameSuccess());

    }on FirebaseAuthException catch (e) {
      emit(ProfileEditNameFailure(error: e.message ?? 'An error occurred'));
    } catch (e) {
      emit(ProfileEditNameFailure(error: e.toString()));
    }
  }

  Future<void> uploadProfilePicture(String path) async {
    emit(ProfileEditPictureLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No logged-in user');
      }

      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${user.uid}.jpg');

      final uploadTaskSnapshot = await ref.putFile(File(path));

      // الحصول على رابط الصورة وتحديث photoURL في FirebaseAuth
      final downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL();
      await user.updatePhotoURL(downloadUrl);

      emit(ProfileEditPictureSuccess());
    } catch (e) {
      emit(ProfileEditPictureFailure(error: e.toString()));
    }
  }
}


