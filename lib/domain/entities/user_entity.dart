import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final Timestamp createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.createdAt,
  });
}
