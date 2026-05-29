import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    required super.username,
    required super.name,
    required super.email,
    super.profilePicture,
    super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // التعديل هنا: بنضمن إن الـ ID لو جه String أو int يتحول صح وميضربش
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null, 
      
      // بنستخدم ?? '' عشان لو السيرفر بعت الحقل null التطبيق ميقفش
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      
      profilePicture: json['profile_picture']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
    );
  }
}