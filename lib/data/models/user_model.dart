import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final Timestamp createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      role: role,
      createdAt: createdAt,
    );
  }
}
