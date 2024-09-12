import 'package:note_book_app/core/failures/updating_failure.dart';
import 'package:note_book_app/data/datasources/data_raw/data_raw.dart';
import 'package:note_book_app/data/datasources/level_details_datasource.dart';
import 'package:note_book_app/data/models/level_details_model.dart';

class LevelDetailsDatasourceImpl implements LevelDetailsDatasource {
  const LevelDetailsDatasourceImpl();

  @override
  Future<List<LevelDetailsModel>> getAllLevelDetails(
      {required String level}) async {
    final raw = DataRaw.levelDetails[level];
    if (raw == null) {
      throw UpdatingFailure(message: 'Dữ liệu đang được cập nhật');
    }
    return (raw as List<dynamic>)
        .map((detail) => LevelDetailsModel(
              name: detail['name'],
              id: detail['id'],
            ))
        .toList();
  }
}
