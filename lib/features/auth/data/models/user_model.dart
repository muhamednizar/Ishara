import 'package:firebase_auth/firebase_auth.dart';
import 'package:ishara/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email});
  factory UserModel.fromFirebase(User user) {
    return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '');
  }
}
