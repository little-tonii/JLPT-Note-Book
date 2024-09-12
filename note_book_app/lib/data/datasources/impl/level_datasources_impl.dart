import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/models/level_model.dart';

class LevelDatasourcesImpl implements LevelDatasource {
  const LevelDatasourcesImpl();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return [
      const LevelModel(name: "N5"),
      const LevelModel(name: "N4"),
      const LevelModel(name: "N3"),
      const LevelModel(name: "N2"),
      const LevelModel(name: "N1"),
    ];
  }
}
