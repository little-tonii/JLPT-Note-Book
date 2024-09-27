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
      throw FirestoreFailure(message: e.message.toString());
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
      throw FirestoreFailure(message: e.message!);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
