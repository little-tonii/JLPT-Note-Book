import 'package:note_book_app/data/models/kunyomi_model.dart';

abstract class KunyomiDatasource {
  Future<List<KunyomiModel>> getAllKunyomisByKanjiId({required String kanjiId});

  Future<bool> createKunyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  });

  Future<bool> updateKunyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
    required String kunyomiId,
  });
}
