import 'package:note_book_app/data/models/onyomi_model.dart';

abstract class OnyomiDatasource {
  Future<List<OnyomiModel>> getAllOnyomisByKanjiId({required String kanjiId});

  Future<bool> createOnyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  });

  Future<bool> updateOnyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
    required String onyomiId,
  });

  Future<bool> deleteOnyomiByKanjiId({
    required String kanjiId,
    required String onyomiId,
  });
}
