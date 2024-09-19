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
      return kanjis.docs.map((kanji) {
        return KanjiModel.fromJson({
          'id': kanji.id,
          'kanji': kanji.data()['kanji'],
          'kun': kanji.data()['kun'],
          'on': kanji.data()['on'],
          'viet': kanji.data()['viet'],
          'level': kanji.data()['level'],
          'createdAt': kanji.data()['createdAt'],
          'kuns': kanji.reference.collection('kun').get().then((data) {
            return data.docs.map((e) {
              return {
                'id': e.id,
                'meaning': e.data()['meaning'],
                'sample': e.data()['sample'],
                'transform': e.data()['transform'],
                'createdAt': e.data()['createdAt'],
              };
            }).toList();
          }),
          'ons': kanji.reference.collection('on').get().then((data) {
            return data.docs.map((e) {
              return {
                'id': e.id,
                'meaning': e.data()['meaning'],
                'sample': e.data()['sample'],
                'transform': e.data()['transform'],
                'createdAt': e.data()['createdAt'],
              };
            }).toList();
          }),
        });
      }).toList();
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    }
  }
}
