import 'package:note_book_app/domain/entities/level_entity.dart';

class LevelModel {
  final String level;
  final String id;

  const LevelModel({required this.level, required this.id});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      level: json['level'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'id': id,
    };
  }

  LevelEntity toEntity() {
    return LevelEntity(
      level: level,
      id: id,
    );
  }
}
