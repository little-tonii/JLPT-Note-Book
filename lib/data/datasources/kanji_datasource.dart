import 'package:note_book_app/data/models/kanji_model.dart';

abstract class KanjiDatasource {
  Future<List<KanjiModel>> getAllKanjisByLevel({
    required String level,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  });

  Future<KanjiModel> createKanjiByLevel({
    required String level,
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
}
