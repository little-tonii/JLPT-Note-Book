import 'package:note_book_app/data/models/kanji_model.dart';

abstract class KanjiDatasource {
  Future<List<KanjiModel>> getAllKanjisByLevel({
    required String level,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  });
}
