import 'package:note_book_app/data/models/level_model.dart';

abstract class LevelDatasource {
  Future<List<LevelModel>> getAllLevels();
  Future<LevelModel> getLevelById({required String id});
  Future<LevelModel> createLevel({required String level});
}
