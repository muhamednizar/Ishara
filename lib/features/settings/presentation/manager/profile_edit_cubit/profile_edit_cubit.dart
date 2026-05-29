import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/profile_avatar_storage.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(ProfileEditInitial());

  Future<void> editProfileName(String name) async {
    emit(ProfileEditNameLoading());
    try {
      final session = await LocalSessionService.instance.readSession();
      if (session == null) {
        emit(ProfileEditNameFailure(error: 'Not signed in'));
        return;
      }
      await LocalSessionService.instance.updateDisplayName(name);
      emit(ProfileEditNameSuccess());
    } catch (e) {
      emit(ProfileEditNameFailure(error: e.toString()));
    }
  }

  /// حفظ مسار الصورة محليًا (بدون رفع لسيرفر).
  Future<void> uploadProfilePicture(String path) async {
    emit(ProfileEditPictureLoading());
    try {
      final session = await LocalSessionService.instance.readSession();
      if (session == null) {
        emit(ProfileEditPictureFailure(error: 'Not signed in'));
        return;
      }
      final permanentPath = await ProfileAvatarStorage.persistPickedImage(path);
      await LocalSessionService.instance.updatePhotoPath(permanentPath);
      emit(ProfileEditPictureSuccess());
    } catch (e) {
      emit(ProfileEditPictureFailure(error: e.toString()));
    }
  }
}
