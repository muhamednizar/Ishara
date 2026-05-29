import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit(this.authRepo) : super(SignUpInitial());

  // الدالة اللي هتتربط بزرار "إنشاء حساب"
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

    final result = await authRepo.signUp(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      ifLeft: (failure) {
        // لو في خطأ (زي الإيميل مستخدم أو الباسوورد مش مطابق للشروط)
        emit(SignUpError(failure));
      },
      ifRight: (user) => emit(SignUpSuccess(user)),
    );
  }
}