import 'package:cloud_firestore/cloud_firestore.dart';

class LessonEntity {
  final String id;
  final String lesson;
  final Timestamp createdAt;
  final String levelId;

  const LessonEntity({
    required this.levelId,
    required this.lesson,
    required this.id,
    required this.createdAt,
  });
}
