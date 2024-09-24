import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/onyomi_datasource.dart';
import 'package:note_book_app/data/models/onyomi_model.dart';

class OnyomiDatasourceImpl implements OnyomiDatasource {
  final FirebaseFirestore firebaseFirestore;

  const OnyomiDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<OnyomiModel>> getAllOnyomisByKanjiId(
      {required String kanjiId}) async {
    try {
      final queryResult = await firebaseFirestore
          .collection('kanjis')
          .doc(kanjiId)
          .collection('on')
          .get();
      List<OnyomiModel> ons = queryResult.docs.map((on) {
        return OnyomiModel.fromJson({
          'id': on.id,
          'meaning': on.data()['meaning'],
          'sample': on.data()['sample'],
          'createdAt': on.data()['createdAt'],
          'transform': on.data()['transform'],
        });
      }).toList();
      ons.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return ons;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    } on Exception {
      throw UnknownFailure();
    }
  }
}
