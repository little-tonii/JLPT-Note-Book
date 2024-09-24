import 'package:cloud_firestore/cloud_firestore.dart';

class OnyomiEntity {
  final String id;
  final String meaning;
  final String sample;
  final String transform;
  final Timestamp createdAt;

  const OnyomiEntity({
    required this.id,
    required this.meaning,
    required this.sample,
    required this.transform,
    required this.createdAt,
  });
}