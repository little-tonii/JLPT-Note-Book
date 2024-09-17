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
      final levels = await firebaseFirestore.collection('levels').get();
      return levels.docs.map((e) {
        return LevelModel.fromJson({
          'level': e.data()['level'],
          'id': e.id,
        });
      }).toList();
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
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
        });
      } else {
        throw DataNotFoundFailure(message: 'Level not found');
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message!);
    }
  }
}
