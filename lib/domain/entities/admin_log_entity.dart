import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLogEntity {
  final String id;
  final String message;
  final Timestamp createdAt;

  const AdminLogEntity({
    required this.id,
    required this.message,
    required this.createdAt,
  });
}
