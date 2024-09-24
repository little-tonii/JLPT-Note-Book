import 'package:cloud_firestore/cloud_firestore.dart';

class LessonEntity {
  final String id;
  final String lesson;
  final String level;
  final Timestamp createdAt;

  const LessonEntity({
    required this.level,
    required this.lesson,
    required this.id,
    required this.createdAt,
  });
}
