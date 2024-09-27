import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/kunyomi_datasource.dart';
import 'package:note_book_app/data/models/kunyomi_model.dart';

class KunyomiDatasourceImpl implements KunyomiDatasource {
  final FirebaseFirestore firebaseFirestore;

  const KunyomiDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<KunyomiModel>> getAllKunyomisByKanjiId(
      {required String kanjiId}) async {
    try {
      final queryResult = await firebaseFirestore
          .collection('kanjis')
          .doc(kanjiId)
          .collection('kun')
          .orderBy('createdAt')
          .get();
      List<KunyomiModel> kuns = queryResult.docs.map((kun) {
        return KunyomiModel.fromJson({
          'id': kun.id,
          'meaning': kun.data()['meaning'],
          'sample': kun.data()['sample'],
          'createdAt': kun.data()['createdAt'],
          'transform': kun.data()['transform'],
        });
      }).toList();
      return kuns;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    } on Exception {
      throw UnknownFailure();
    }
  }
}
