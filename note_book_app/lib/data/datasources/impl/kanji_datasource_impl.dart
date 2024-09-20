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
      List<KanjiModel> kanjiList = [];
      for (var kanji in kanjis.docs) {
        final kuns = await kanji.reference.collection('kun').get();
        final ons = await kanji.reference.collection('on').get();
        kanjiList.add(KanjiModel.fromJson({
          'id': kanji.id,
          'kanji': kanji.data()['kanji'],
          'kun': kanji.data()['kun'],
          'on': kanji.data()['on'],
          'viet': kanji.data()['viet'],
          'level': kanji.data()['level'],
          'createdAt': kanji.data()['createdAt'],
          'kuns': kuns.docs.map((kun) {
            return {
              'id': kun.id,
              'meaning': kun.data()['meaning'],
              'sample': kun.data()['sample'],
              'transform': kun.data()['transform'],
              'createdAt': kun.data()['createdAt'],
            };
          }).toList(),
          'ons': ons.docs.map((on) {
            return {
              'id': on.id,
              'meaning': on.data()['meaning'],
              'sample': on.data()['sample'],
              'transform': on.data()['transform'],
              'createdAt': on.data()['createdAt'],
            };
          }).toList(),
        }));
        kanjiList.last.kunModels
            .sort((a, b) => a.createdAt.compareTo(b.createdAt));
        kanjiList.last.onModels
            .sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }

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
