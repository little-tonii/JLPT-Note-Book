import 'package:note_book_app/core/failures/updating_failure.dart';
import 'package:note_book_app/data/datasources/data_raw/data_raw.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/models/lesson_model.dart';

class LessonDatasourceImpl implements LessonDatasource {
  const LessonDatasourceImpl();

  @override
  Future<List<LessonModel>> getAllLessonsByLevel(
      {required String level}) async {
    final raw = DataRaw.lessons[level];
    if (raw == null) {
      throw UpdatingFailure(message: 'Dữ liệu đang được cập nhật');
    }
    return (raw as List<dynamic>)
        .map((lesson) => LessonModel(
              level: level,
              lesson: lesson['lesson'],
              id: lesson['id'],
            ))
        .toList();
  }
}
