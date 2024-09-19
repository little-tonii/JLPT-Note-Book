import 'package:cloud_firestore/cloud_firestore.dart';

class KanjiEntity {
  final String id;
  final String kanji;
  final String kun;
  final String on;
  final String viet;
  final List<KunEntity> kunEntities;
  final List<OnEntity> onEntities;
  final Timestamp createdAt;

  const KanjiEntity({
    required this.id,
    required this.kanji,
    required this.kun,
    required this.on,
    required this.viet,
    required this.kunEntities,
    required this.onEntities,
    required this.createdAt,
  });
}

class KunEntity {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const KunEntity({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });
}

class OnEntity {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const OnEntity({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });
}
