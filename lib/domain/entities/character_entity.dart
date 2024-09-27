import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterEntity {
  final String id;
  final String romanji;
  final String hiragana;
  final String katakana;
  final Timestamp createdAt;

  const CharacterEntity({
    required this.id,
    required this.romanji,
    required this.hiragana,
    required this.katakana,
    required this.createdAt,
  });
}
