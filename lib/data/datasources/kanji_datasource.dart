import 'package:note_book_app/data/models/kanji_model.dart';

abstract class KanjiDatasource {
  Future<List<KanjiModel>> getAllKanjisByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  });

  Future<KanjiModel> createKanjiByLevelId({
    required String levelId,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  });

  Future<bool> updateKanjiById({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  });

  Future<bool> deleteKanjiById({required String id});

  Future<int> deleteKanjisByLevelId({required String levelId});
}
