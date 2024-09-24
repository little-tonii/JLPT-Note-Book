import 'package:note_book_app/data/models/onyomi_model.dart';

abstract class OnyomiDatasource {
  Future<List<OnyomiModel>> getAllOnyomisByKanjiId({required String kanjiId});
}