import 'package:bloc/bloc.dart';
import 'package:ishara/features/auth/data/models/user_model.dart';
import 'package:ishara/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp(String name, String email, String password) async {
    emit(SignUpLoading());
    var result = await authRepo.signUpWithNameEmailPassword(name: name, email: email, password: password);
    result.fold(
      ifLeft: (failure){
        emit(SignUpFailure(failure.message));
      },
      ifRight: (user){
        emit(SignUpSuccess(user));
      },
    );
  }
}
