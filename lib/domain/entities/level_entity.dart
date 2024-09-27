import 'package:cloud_firestore/cloud_firestore.dart';

class LevelEntity {
  final String id;
  final String level;
  final Timestamp createdAt;

  const LevelEntity({
    required this.level,
    required this.id,
    required this.createdAt,
  });
}
