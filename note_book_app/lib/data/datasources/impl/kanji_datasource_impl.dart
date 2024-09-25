import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/data/models/kanji_model.dart';

class KanjiDatasourceImpl implements KanjiDatasource {
  final FirebaseFirestore firebaseFirestore;

  const KanjiDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<KanjiModel>> getAllKanjisByLevel({
    required String level,
    required int pageSize,
    required int pageNumber,
  }) async {
    try {
      Query<Map<String, dynamic>> query = firebaseFirestore
          .collection('kanjis')
          .where('level', isEqualTo: level)
          .orderBy('createdAt')
          .limit(pageSize);
      if (pageNumber > 1) {
        final lastVisibleOfPreviousPage = await firebaseFirestore
            .collection('kanjis')
            .where('level', isEqualTo: level)
            .orderBy('createdAt')
            .limit((pageNumber - 1) * pageSize)
            .get();

        if (lastVisibleOfPreviousPage.docs.isNotEmpty) {
          final lastDoc = lastVisibleOfPreviousPage.docs.last;
          query = query.startAfter([lastDoc['createdAt']]);
        }
      }
      final kanjis = await query.get();
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
      return kanjiList;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
