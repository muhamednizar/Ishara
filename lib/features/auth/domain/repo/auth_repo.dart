import 'package:dart_either/dart_either.dart';
import 'package:ishara/core/errors/failure.dart';
import 'package:ishara/features/auth/data/models/user_model.dart';
import 'package:ishara/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure , UserModel>> signUpWithNameEmailPassword({required String name , required String email , required String password});
  Future<Either<Failure , UserModel>> signInWithEmailAndPassword({required String email , required String password});
}

