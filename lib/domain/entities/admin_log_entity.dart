import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLogEntity {
  final String id;
  final String message;
  final String action;
  final Timestamp createdAt;
  final String actionStatus;
  final String userEmail;

  const AdminLogEntity({
    required this.action,
    required this.id,
    required this.message,
    required this.createdAt,
    required this.actionStatus,
    required this.userEmail,
  });
}
