import 'dart:developer';

import 'package:dart_either/src/dart_either.dart';
import 'package:ishara/core/errors/exceptions.dart';
import 'package:ishara/core/errors/failure.dart';
import 'package:ishara/core/services/local_auth_service.dart';
import 'package:ishara/features/auth/data/models/user_model.dart';
import 'package:ishara/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final LocalAuthService authService;
  AuthRepoImpl({required this.authService});

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(user);
    } on CustomException catch (e) {
      log('error in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      log('error in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return Left(ServerFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithNameEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authService.signUpWithNameEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on CustomException catch (e) {
      log('error in AuthRepoImpl.signUpWithNameEmailPassword: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      log('error in AuthRepoImpl.signUpWithNameEmailPassword: ${e.toString()}');
      return Left(ServerFailure('Something went wrong'));
    }
  }
}
