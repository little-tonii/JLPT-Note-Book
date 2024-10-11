import 'package:cloud_firestore/cloud_firestore.dart';

class WordEntity {
  final String id;
  final String word;
  final String meaning;
  final String levelId;
  final String lessonId;
  final Timestamp createdAt;
  final String kanjiForm;

  const WordEntity({
    required this.id,
    required this.word,
    required this.meaning,
    required this.levelId,
    required this.lessonId,
    required this.createdAt,
    required this.kanjiForm,
  });
}
