import 'package:note_book_app/data/models/lesson_model.dart';

abstract class LessonDatasource {
  Future<List<LessonModel>> getAllLessonsByLevelId({required String levelId});
  Future<LessonModel> getLessonById({required String id});
  Future<int> deleteLessonsByLevelId({required String levelId});
  Future<LessonModel> createLessonByLevelId(
      {required String levelId, required String lesson});
  Future<LessonModel> updateLessonById(
      {required String id, required String lesson});
}
