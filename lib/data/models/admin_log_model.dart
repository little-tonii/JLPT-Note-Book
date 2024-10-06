import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';

class AdminLogModel {
  final String id;
  final String message;
  final Timestamp createdAt;
  final String action;
  final String actionStatus;
  final String userEmail;

  const AdminLogModel({
    required this.action,
    required this.id,
    required this.message,
    required this.createdAt,
    required this.actionStatus,
    required this.userEmail,
  });

  factory AdminLogModel.fromJson(Map<String, dynamic> map) {
    return AdminLogModel(
      id: map['id'],
      action: map['action'],
      message: map['message'],
      createdAt: map['createdAt'],
      actionStatus: map['actionStatus'],
      userEmail: map['userEmail'],
    );
  }

  AdminLogEntity toEntity() {
    return AdminLogEntity(
      action: action,
      id: id,
      message: message,
      createdAt: createdAt,
      actionStatus: actionStatus,
      userEmail: userEmail,
    );
  }
}
