import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/data/models/kanji_model.dart';

class KanjiDatasourceImpl implements KanjiDatasource {
  final FirebaseFirestore firebaseFirestore;

  const KanjiDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<KanjiModel>> getAllKanjisByLevel({required String level}) async {
    try {
      final kanjis = await firebaseFirestore
          .collection('kanjis')
          .where('level', isEqualTo: level)
          .get();
      List<KanjiModel> kanjiList = kanjis.docs.map((kanji) {
        return KanjiModel.fromJson({
          'id': kanji.id,
          'kanji': kanji.data()['kanji'],
          'kun': kanji.data()['kun'],
          'on': kanji.data()['on'],
          'viet': kanji.data()['viet'],
          'level': kanji.data()['level'],
          'createdAt': kanji.data()['createdAt'],
        });
      }).toList();
      kanjiList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return kanjiList;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
