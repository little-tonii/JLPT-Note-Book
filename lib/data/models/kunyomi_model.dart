import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';

class KunyomiModel {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const KunyomiModel({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });

  factory KunyomiModel.fromJson(Map<String, dynamic> json) {
    return KunyomiModel(
      id: json['id'],
      meaning: json['meaning'],
      sample: json['sample'],
      transform: json['transform'],
      createdAt: json['createdAt'],
    );
  }

  KunyomiEntity toEntity() {
    return KunyomiEntity(
      id: id,
      meaning: meaning,
      sample: sample,
      transform: transform,
      createdAt: createdAt,
    );
  }
}
