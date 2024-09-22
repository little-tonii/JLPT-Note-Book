import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

class KanjiModel {
  final String id;
  final String kanji;
  final String kun;
  final String on;
  final String viet;
  final List<KunModel> kunModels;
  final List<OnModel> onModels;
  final String level;
  final Timestamp createdAt;

  const KanjiModel({
    required this.id,
    required this.kanji,
    required this.kun,
    required this.on,
    required this.viet,
    required this.kunModels,
    required this.onModels,
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
      kunModels:
          (json['kuns'] as List).map((e) => KunModel.fromJson(e)).toList(),
      onModels: (json['ons'] as List).map((e) => OnModel.fromJson(e)).toList(),
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
      kunEntities: kunModels.map((e) => e.toEntity()).toList(),
      onEntities: onModels.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
    );
  }
}

class KunModel {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const KunModel({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });

  factory KunModel.fromJson(Map<String, dynamic> json) {
    return KunModel(
      id: json['id'],
      meaning: json['meaning'],
      sample: json['sample'],
      transform: json['transform'],
      createdAt: json['createdAt'],
    );
  }

  KunEntity toEntity() {
    return KunEntity(
      id: id,
      meaning: meaning,
      sample: sample,
      transform: transform,
      createdAt: createdAt,
    );
  }
}

class OnModel {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const OnModel({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });

  factory OnModel.fromJson(Map<String, dynamic> json) {
    return OnModel(
      id: json['id'],
      meaning: json['meaning'],
      sample: json['sample'],
      transform: json['transform'],
      createdAt: json['createdAt'],
    );
  }

  OnEntity toEntity() {
    return OnEntity(
      id: id,
      meaning: meaning,
      sample: sample,
      transform: transform,
      createdAt: createdAt,
    );
  }
}
