import 'package:note_book_app/domain/entities/level_details_entity.dart';

class LevelDetailsModel {
  final String id;
  final String name;
  final String level;

  const LevelDetailsModel({
    required this.name,
    required this.id,
    required this.level,
  });

  factory LevelDetailsModel.fromJson(Map<String, dynamic> json) {
    return LevelDetailsModel(
      name: json['name'],
      id: json['id'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
    };
  }

  LevelDetailsEntity toEntity() {
    return LevelDetailsEntity(
      name: name,
      id: id,
      level: level,
    );
  }
}
