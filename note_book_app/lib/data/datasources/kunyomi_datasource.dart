import 'package:note_book_app/data/models/kunyomi_model.dart';

abstract class KunyomiDatasource {
  Future<List<KunyomiModel>> getAllKunyomisByKanjiId({required String kanjiId});
}
