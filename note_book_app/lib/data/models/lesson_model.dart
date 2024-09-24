import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

class LessonModel {
  final String id;
  final String lesson;
  final String level;
  final Timestamp createdAt;

  const LessonModel({
    required this.lesson,
    required this.id,
    required this.level,
    required this.createdAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      lesson: json['lesson'],
      id: json['id'],
      level: json['level'],
      createdAt: json['createdAt'],
    );
  }

  LessonEntity toEntity() {
    return LessonEntity(
      lesson: lesson,
      id: id,
      level: level,
      createdAt: createdAt,
    );
  }
}
