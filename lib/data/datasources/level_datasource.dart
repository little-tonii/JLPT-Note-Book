import 'package:note_book_app/data/models/level_model.dart';

abstract class LevelDatasource {
  Future<List<LevelModel>> getAllLevels();
  Future<LevelModel> getLevelById({required String id});
  Future<LevelModel> createLevel({required String level});
  Future<bool> deleteLevelById({required String id});
  Future<LevelModel> updateLevelById(
      {required String id, required String level});
}
