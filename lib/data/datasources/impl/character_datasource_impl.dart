import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/data/models/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final FirebaseFirestore firebaseFirestore;

  const CharacterDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      final result = await firebaseFirestore
          .collection('characters')
          .orderBy('createdAt')
          .get();
      List<CharacterModel> characters = result.docs.map((character) {
        return CharacterModel.fromJson({
          'id': character.id,
          'romanji': character.data()['romanji'],
          'hiragana': character.data()['hiragana'],
          'katakana': character.data()['katakana'],
          'createdAt': character.data()['createdAt'],
        });
      }).toList();
      return characters;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
        message: "Có lỗi xảy ra khi truy cập bảng chữ cái",
      );
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
