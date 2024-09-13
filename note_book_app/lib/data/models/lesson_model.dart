import 'package:note_book_app/domain/entities/lesson_entity.dart';

class LessonModel {
  final String id;
  final String lesson;
  final String level;

  const LessonModel({
    required this.lesson,
    required this.id,
    required this.level,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      lesson: json['lesson'],
      id: json['id'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lesson': lesson,
      'level': level,
    };
  }

  LessonEntity toEntity() {
    return LessonEntity(
      lesson: lesson,
      id: id,
      level: level,
    );
  }
}
