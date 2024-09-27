import 'package:note_book_app/data/models/character_model.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> getAllCharacters();
}
