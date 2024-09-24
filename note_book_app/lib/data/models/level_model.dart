import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

class LevelModel {
  final String level;
  final String id;
  final Timestamp createdAt;

  const LevelModel({
    required this.level,
    required this.id,
    required this.createdAt,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      level: json['level'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }

  LevelEntity toEntity() {
    return LevelEntity(
      level: level,
      id: id,
      createdAt: createdAt,
    );
  }
}
