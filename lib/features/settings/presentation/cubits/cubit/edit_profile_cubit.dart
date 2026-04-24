import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ishara/core/services/local_session_service.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfileName(String name) async {
    emit(EditProfileNameLoading());
    try {
      final session = await LocalSessionService.instance.readSession();
      if (session == null) {
        emit(EditProfileNameFailure(error: 'Not signed in'));
        return;
      }
      await LocalSessionService.instance.updateDisplayName(name);
      emit(EditProfileNameSuccess());
    } catch (e) {
      emit(EditProfileNameFailure(error: e.toString()));
    }
  }
}
