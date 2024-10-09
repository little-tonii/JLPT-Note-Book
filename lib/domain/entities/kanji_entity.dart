import 'package:cloud_firestore/cloud_firestore.dart';

class KanjiEntity {
  final String id;
  final String kanji;
  final String kun;
  final String on;
  final String viet;
  final String levelId;
  final Timestamp createdAt;

  const KanjiEntity({
    required this.levelId,
    required this.id,
    required this.kanji,
    required this.kun,
    required this.on,
    required this.viet,
    required this.createdAt,
  });

  KanjiEntity copyWith({
    String? id,
    String? kanji,
    String? kun,
    String? on,
    String? viet,
    String? levelId,
  }) {
    return KanjiEntity(
      levelId: levelId ?? this.levelId,
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kun: kun ?? this.kun,
      on: on ?? this.on,
      viet: viet ?? this.viet,
      createdAt: createdAt,
    );
  }
}
