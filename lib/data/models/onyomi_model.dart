
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';

class OnyomiModel {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const OnyomiModel({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });

  factory OnyomiModel.fromJson(Map<String, dynamic> json) {
    return OnyomiModel(
      id: json['id'],
      meaning: json['meaning'],
      sample: json['sample'],
      transform: json['transform'],
      createdAt: json['createdAt'],
    );
  }

  OnyomiEntity toEntity() {
    return OnyomiEntity(
      id: id,
      meaning: meaning,
      sample: sample,
      transform: transform,
      createdAt: createdAt,
    );
  }
}
