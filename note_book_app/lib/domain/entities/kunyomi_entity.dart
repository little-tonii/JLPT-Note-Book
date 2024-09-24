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
}