import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';

class CharacterModel {
  final String id;
  final String romanji;
  final String hiragana;
  final String katakana;
  final Timestamp createdAt;

  const CharacterModel({
    required this.id,
    required this.romanji,
    required this.hiragana,
    required this.katakana,
    required this.createdAt,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      romanji: json['romanji'],
      hiragana: json['hiragana'],
      katakana: json['katakana'],
      createdAt: json['createdAt'],
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      romanji: romanji,
      hiragana: hiragana,
      katakana: katakana,
      createdAt: createdAt,
    );
  }
}
