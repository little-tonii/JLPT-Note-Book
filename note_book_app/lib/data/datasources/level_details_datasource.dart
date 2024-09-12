import 'package:note_book_app/data/models/level_details_model.dart';

abstract class LevelDetailsDatasource {
  Future<List<LevelDetailsModel>> getAllLevelDetails({
    required String level,
  });
}
