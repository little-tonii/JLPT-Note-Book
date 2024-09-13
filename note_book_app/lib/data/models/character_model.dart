import 'package:note_book_app/domain/entities/character_entity.dart';

class CharacterModel {
  final String romanji;
  final String hiragana;
  final String katakana;

  const CharacterModel({
    required this.romanji,
    required this.hiragana,
    required this.katakana,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      romanji: json['romanji'],
      hiragana: json['hiragana'],
      katakana: json['katakana'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'romanji': romanji,
      'hiragana': hiragana,
      'katakana': katakana,
    };
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      romanji: romanji,
      hiragana: hiragana,
      katakana: katakana,
    );
  }
}
