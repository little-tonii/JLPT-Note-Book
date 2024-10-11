import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';

class WordModel {
  final String id;
  final String word;
  final String meaning;
  final String levelId;
  final String lessonId;
  final Timestamp createdAt;
  final String kanjiForm;

  const WordModel({
    required this.id,
    required this.word,
    required this.meaning,
    required this.levelId,
    required this.lessonId,
    required this.createdAt,
    required this.kanjiForm,
  });

  factory WordModel.fromJson(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      word: map['word'],
      meaning: map['meaning'],
      levelId: map['levelId'],
      lessonId: map['lessonId'],
      createdAt: map['createdAt'],
      kanjiForm: map['kanjiForm'],
    );
  }

  WordEntity toEntity() {
    return WordEntity(
      id: id,
      word: word,
      meaning: meaning,
      levelId: levelId,
      lessonId: lessonId,
      createdAt: createdAt,
      kanjiForm: kanjiForm,
    );
  }
}
