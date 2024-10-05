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
    required String hanVietSearchKey,
  }) async {
    try {
      Query<Map<String, dynamic>> query = firebaseFirestore
          .collection('kanjis')
          .where('level', isEqualTo: level);

      if (hanVietSearchKey.isNotEmpty) {
        hanVietSearchKey = hanVietSearchKey[0].toUpperCase() +
            hanVietSearchKey.substring(1).toLowerCase();
        query = query.where('viet', isEqualTo: hanVietSearchKey);
      }

      query = query.orderBy('createdAt');

      if (pageNumber > 1) {
        Query<Map<String, dynamic>> previousPageQuery = firebaseFirestore
            .collection('kanjis')
            .where('level', isEqualTo: level);

        if (hanVietSearchKey.isNotEmpty) {
          previousPageQuery =
              previousPageQuery.where('viet', isEqualTo: hanVietSearchKey);
        }

        final lastVisibleOfPreviousPage = await previousPageQuery
            .orderBy('createdAt')
            .limit((pageNumber - 1) * pageSize)
            .get();

        if (lastVisibleOfPreviousPage.docs.isNotEmpty) {
          final lastDoc = lastVisibleOfPreviousPage.docs.last;
          query = query.startAfter([lastDoc['createdAt']]);
        }
      }

      query = query.limit(pageSize);

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

  @override
  Future<bool> createKanjiByLevel({
    required String level,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    try {
      await firebaseFirestore.collection('kanjis').add({
        'kanji': kanji,
        'kun': kun,
        'on': on,
        'viet': viet,
        'level': level,
        'createdAt': Timestamp.now(),
      });
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateKanjiById({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    try {
      await firebaseFirestore.collection('kanjis').doc(id).update({
        'kanji': kanji,
        'kun': kun,
        'on': on,
        'viet': viet,
      });
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
