import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModal extends User {
  const UserModal({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModal.fromJson(Map<String, dynamic> map) {
    return UserModal(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
