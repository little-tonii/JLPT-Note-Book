import 'package:note_book_app/domain/entities/level_entity.dart';

class LevelModel {
  final String name;

  const LevelModel({required this.name});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  LevelEntity toEntity() {
    return LevelEntity(name: name);
  }
}
