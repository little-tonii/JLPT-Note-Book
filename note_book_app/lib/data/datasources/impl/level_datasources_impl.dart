import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/models/level_model.dart';

class LevelDatasourcesImpl implements LevelDatasource {
  const LevelDatasourcesImpl();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return [
      LevelModel(name: "N5"),
      LevelModel(name: "N4"),
      LevelModel(name: "N3"),
      LevelModel(name: "N2"),
      LevelModel(name: "N1"),
    ];
  }
}
