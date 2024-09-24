import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

class KanjiModel {
  final String id;
  final String kanji;
  final String kun;
  final String on;
  final String viet;
  final String level;
  final Timestamp createdAt;

  const KanjiModel({
    required this.id,
    required this.kanji,
    required this.kun,
    required this.on,
    required this.viet,
    required this.level,
    required this.createdAt,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) {
    return KanjiModel(
      id: json['id'],
      kanji: json['kanji'],
      kun: json['kun'],
      on: json['on'],
      viet: json['viet'],
      level: json['level'],
      createdAt: json['createdAt'],
    );
  }

  KanjiEntity toEntity() {
    return KanjiEntity(
      id: id,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
      createdAt: createdAt,
    );
  }
}
