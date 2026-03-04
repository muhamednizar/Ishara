import 'package:bloc/bloc.dart';
import 'package:ishara/features/auth/data/models/user_model.dart';
import 'package:ishara/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit({required this.authRepo}) : super(LoginInitial());
  
  Future<void> login (String email , String password) async {
    emit(LoginLoading());
    var result = await authRepo.signInWithEmailAndPassword(email: email, password: password);
    result.fold(
      ifLeft: (failure){
        emit(LoginFailure(failure.message));
      },
      ifRight: (user){
        emit(LoginSuccess(user));
      },
    );  
  }
}
