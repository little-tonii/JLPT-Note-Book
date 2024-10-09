import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

class LessonModel {
  final String id;
  final String lesson;
  final Timestamp createdAt;
  final String levelId;

  const LessonModel({
    required this.levelId,
    required this.lesson,
    required this.id,
    required this.createdAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      levelId: json['levelId'],
      lesson: json['lesson'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }

  LessonEntity toEntity() {
    return LessonEntity(
      levelId: levelId,
      lesson: lesson,
      id: id,
      createdAt: createdAt,
    );
  }
}
