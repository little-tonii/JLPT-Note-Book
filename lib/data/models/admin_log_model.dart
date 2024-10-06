import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';

class AdminLogModel {
  final String id;
  final String message;
  final Timestamp createdAt;

  const AdminLogModel({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory AdminLogModel.fromJson(Map<String, dynamic> map) {
    return AdminLogModel(
      id: map['id'],
      message: map['message'],
      createdAt: map['createdAt'],
    );
  }

  AdminLogEntity toEntity() {
    return AdminLogEntity(
      id: id,
      message: message,
      createdAt: createdAt,
    );
  }
}
