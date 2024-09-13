import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/data/datasources/data_raw/data_raw.dart';
import 'package:note_book_app/data/models/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  const CharacterDatasourceImpl();

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return DataRaw.characters
        .map((raw) => CharacterModel.fromJson(raw))
        .toList();
  }
}
