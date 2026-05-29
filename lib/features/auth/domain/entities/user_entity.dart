class UserEntity {
  final int? id; 
  final String username;
  final String name;
  final String email;
  final String? profilePicture;
  final String? phoneNumber;

  UserEntity({
    this.id,
    required this.username,
    required this.name,
    required this.email,
    this.profilePicture,
    this.phoneNumber,
  });
}