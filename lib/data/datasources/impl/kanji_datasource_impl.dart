import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/data/models/kanji_model.dart';

class KanjiDatasourceImpl implements KanjiDatasource {
  final FirebaseFirestore firebaseFirestore;

  const KanjiDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<KanjiModel>> getAllKanjisByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  }) async {
    try {
      Query<Map<String, dynamic>> query = firebaseFirestore
          .collection('kanjis')
          .where('levelId', isEqualTo: levelId);

      if (hanVietSearchKey.isNotEmpty) {
        hanVietSearchKey = hanVietSearchKey[0].toUpperCase() +
            hanVietSearchKey.substring(1).toLowerCase();
        query = query.where('viet', isEqualTo: hanVietSearchKey);
      }

      query = query.orderBy('createdAt');

      if (pageNumber > 1) {
        Query<Map<String, dynamic>> previousPageQuery = firebaseFirestore
            .collection('kanjis')
            .where('levelId', isEqualTo: levelId);

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
          'createdAt': kanji.data()['createdAt'],
          'levelId': kanji.data()['levelId'],
        });
      }).toList();

      return kanjiList;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi truy cập Kanji");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<KanjiModel> createKanjiByLevelId({
    required String levelId,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    try {
      final kanjiDoc = await firebaseFirestore.collection('kanjis').add({
        'kanji': kanji,
        'kun': kun,
        'on': on,
        'viet': viet,
        'levelId': levelId,
        'createdAt': Timestamp.now(),
      });

      final kanjiData = await kanjiDoc.get();
      return KanjiModel.fromJson({
        'id': kanjiDoc.id,
        'kanji': kanjiData.data()!['kanji'],
        'kun': kanjiData.data()!['kun'],
        'on': kanjiData.data()!['on'],
        'viet': kanjiData.data()!['viet'],
        'createdAt': kanjiData.data()!['createdAt'],
        'levelId': kanjiData.data()!['levelId'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi tạo Kanji");
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

  @override
  Future<bool> deleteKanjiById({required String id}) async {
    try {
      await firebaseFirestore.collection('kanjis').doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> deleteKanjisByLevelId({required String levelId}) async {
    try {
      final kanjis = await firebaseFirestore
          .collection('kanjis')
          .where('levelId', isEqualTo: levelId)
          .get();

      for (final kanji in kanjis.docs) {
        await kanji.reference.delete();
      }

      return kanjis.docs.length;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
          message: "Có lỗi xảy ra khi xóa các Kanji khi xoá JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
