import 'package:note_book_app/domain/entities/level_details_entity.dart';

class LevelDetailsModel {
  final String id;
  final String name;

  const LevelDetailsModel({required this.name, required this.id});

  factory LevelDetailsModel.fromJson(Map<String, dynamic> json) {
    return LevelDetailsModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  LevelDetailsEntity toEntity() {
    return LevelDetailsEntity(
      name: name,
      id: id,
    );
  }
}
