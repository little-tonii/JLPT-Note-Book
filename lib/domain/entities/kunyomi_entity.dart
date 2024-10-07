import 'package:cloud_firestore/cloud_firestore.dart';

class KunyomiEntity {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const KunyomiEntity({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });

  KunyomiEntity copyWith({
    String? id,
    String? meaning,
    String? sample,
    String? transform,
  }) {
    return KunyomiEntity(
      id: id ?? this.id,
      meaning: meaning ?? this.meaning,
      sample: sample ?? this.sample,
      transform: transform ?? this.transform,
      createdAt: createdAt,
    );
  }
}
