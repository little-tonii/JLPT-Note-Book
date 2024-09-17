import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/models/lesson_model.dart';

class LessonDatasourceImpl implements LessonDatasource {
  final FirebaseFirestore firebaseFirestore;

  const LessonDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<LessonModel>> getAllLessonsByLevel(
      {required String level}) async {
    try {
      final lessons = await firebaseFirestore
          .collection('lessons')
          .where('level', isEqualTo: level)
          .get();
      return lessons.docs
          .map((lesson) => LessonModel.fromJson({
                'id': lesson.id,
                'lesson': lesson.data()['lesson'],
                'level': lesson.data()['level'],
              }))
          .toList();
    } on FirebaseException catch (e) {
      log(e.message.toString());
      throw FirestoreFailure(message: e.message.toString());
    }
  }

  @override
  Future<LessonModel> getLessonById({required String id}) async {
    try {
      final lesson =
          await firebaseFirestore.collection('lessons').doc(id).get();
      return LessonModel.fromJson({
        'id': lesson.id,
        'lesson': lesson.data()!['lesson'],
        'level': lesson.data()!['level'],
      });
    } on FirebaseException catch (e) {
      log(e.message.toString());
      throw FirestoreFailure(message: e.message.toString());
    }
  }
}
