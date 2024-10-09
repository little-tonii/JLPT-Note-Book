import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/data_not_found_failure.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/models/level_model.dart';

class LevelDatasourcesImpl implements LevelDatasource {
  final FirebaseFirestore firebaseFirestore;

  const LevelDatasourcesImpl({required this.firebaseFirestore});

  @override
  Future<List<LevelModel>> getAllLevels() async {
    try {
      final queryResult = await firebaseFirestore.collection('levels').get();
      final levels = queryResult.docs.map((e) {
        return LevelModel.fromJson({
          'level': e.data()['level'],
          'id': e.id,
          'createdAt': e.data()['createdAt'],
        });
      }).toList();
      levels.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return levels;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi truy cập tất cả JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LevelModel> getLevelById({required String id}) async {
    try {
      final level = await firebaseFirestore.collection('levels').doc(id).get();
      if (level.exists) {
        return LevelModel.fromJson({
          'level': level.data()!['level'],
          'id': level.id,
          'createdAt': level.data()!['createdAt'],
        });
      } else {
        throw DataNotFoundFailure(message: 'Level not found');
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi truy cập JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LevelModel> createLevel({required String level}) async {
    try {
      final levelRef = await firebaseFirestore.collection('levels').add({
        'level': level,
        'createdAt': Timestamp.now(),
      });
      final levelDoc = await levelRef.get();
      return LevelModel.fromJson({
        'level': levelDoc.data()!['level'],
        'id': levelDoc.id,
        'createdAt': levelDoc.data()!['createdAt'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi tạo JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteLevelById({required String id}) async {
    try {
      await firebaseFirestore.collection('levels').doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi xóa JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
