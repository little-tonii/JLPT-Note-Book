import 'package:note_book_app/domain/entities/level_entity.dart';

class LevelModel {
  final String name;
  final String id;

  const LevelModel({required this.name, required this.id});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  LevelEntity toEntity() {
    return LevelEntity(
      name: name,
      id: id,
    );
  }
}
