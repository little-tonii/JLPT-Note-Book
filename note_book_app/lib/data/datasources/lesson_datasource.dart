import 'package:note_book_app/data/models/lesson_model.dart';

abstract class LessonDatasource {
  Future<List<LessonModel>> getAllLessonsByLevel({
    required String level,
  });
}
