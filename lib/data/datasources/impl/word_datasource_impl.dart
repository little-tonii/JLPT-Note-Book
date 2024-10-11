import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/word_datasource.dart';
import 'package:note_book_app/data/models/word_model.dart';

class WordDatasourceImpl implements WordDatasource {
  final FirebaseFirestore firestore;

  const WordDatasourceImpl({required this.firestore});

  @override
  Future<WordModel> deleteWordById({required String id}) async {
    try {
      final querySnapshot = firestore.collection("words").doc(id);
      final wordDoc = await querySnapshot.get();
      await querySnapshot.delete();
      return WordModel.fromJson({
        "id": wordDoc.id,
        "word": wordDoc.data()!["word"],
        "meaning": wordDoc.data()!["meaning"],
        "kanjiForm": wordDoc.data()!["kanjiForm"],
        "lessonId": wordDoc.data()!["lessonId"],
        "levelId": wordDoc.data()!["levelId"],
        "createdAt": wordDoc.data()!["createdAt"],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi thực hiện xoá từ vựng",
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<WordModel>> getAllWordsByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
  }) {
    // TODO: implement getAllWordsByLevelId
    throw UnimplementedError();
  }

  @override
  Future<List<WordModel>> getAllWordsByLevelIdAndLessonId({
    required String lessonId,
    required String levelId,
    required int pageSize,
    required int pageNumber,
  }) {
    // TODO: implement getAllWordsByLevelIdAndLessonId
    throw UnimplementedError();
  }

  @override
  Future<WordModel> updateWordById(
      {required String id,
      required String word,
      required String meaning,
      required String kanjiForm}) async {
    try {
      final querySnapshot = firestore.collection("words").doc(id);
      final wordDoc = await querySnapshot.get();
      await querySnapshot.update({
        "word": word,
        "meaning": meaning,
        "kanjiForm": kanjiForm,
      });
      return WordModel.fromJson({
        "id": wordDoc.id,
        "word": word,
        "meaning": meaning,
        "kanjiForm": kanjiForm,
        "lessonId": wordDoc.data()!["lessonId"],
        "levelId": wordDoc.data()!["levelId"],
        "createdAt": wordDoc.data()!["createdAt"],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi cập nhật từ vựng",
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<WordModel> createWordByLevelIdAndLessonId(
      {required String levelId,
      required String lessonId,
      required String word,
      required String meaning,
      required String kanjiForm}) async {
    try {
      final wordRef = firestore.collection("words").doc();
      final createdAt = Timestamp.now();
      await wordRef.set({
        "word": word,
        "meaning": meaning,
        "kanjiForm": kanjiForm,
        "lessonId": lessonId,
        "levelId": levelId,
        "createdAt": createdAt,
      });
      return WordModel.fromJson({
        "id": wordRef.id,
        "word": word,
        "meaning": meaning,
        "kanjiForm": kanjiForm,
        "lessonId": lessonId,
        "levelId": levelId,
        "createdAt": createdAt,
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi tạo từ vựng",
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<int> deleteWordByLessonId({required String lessonId}) async {
    try {
      final result = await firestore
          .collection("words")
          .where("lessonId", isEqualTo: lessonId)
          .get();
      for (final doc in result.docs) {
        await doc.reference.delete();
      }
      return result.size;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi thực hiện xoá từ vựng theo bài học",
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<int> deleteWordByLevelId({required String levelId}) async {
    try {
      final result = await firestore
          .collection("words")
          .where("levelId", isEqualTo: levelId)
          .get();
      for (final doc in result.docs) {
        await doc.reference.delete();
      }
      return result.size;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi thực hiện xoá từ vựng theo JLPT",
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
