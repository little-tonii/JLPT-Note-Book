import 'package:note_book_app/data/datasources/data_raw/data_raw.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/models/level_model.dart';

class LevelDatasourcesImpl implements LevelDatasource {
  const LevelDatasourcesImpl();

  @override
  Future<List<LevelModel>> getAllLevels() async {
    return DataRaw.levels
        .map((rawLevel) => LevelModel(
              name: rawLevel['name'],
              id: rawLevel['id'],
            ))
        .toList();
  }
}
