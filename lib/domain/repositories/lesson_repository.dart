import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class LessonRepository {
  Future<Either<Failure, List<LessonEntity>>> getAllLessonsByLevelId(
      {required String levelId});
  Future<Either<Failure, LessonEntity>> getLessonById({required String id});
  Future<Either<Failure, int>> deleteLessonsByLevelId(
      {required String levelId});
  Future<Either<Failure, LessonEntity>> createLessonByLevelId(
      {required String levelId, required String lesson});
  Future<Either<Failure, LessonEntity>> updateLessonById(
      {required String id, required String lesson});
  Future<Either<Failure, LessonEntity>> deleteLessonById({required String id});
}
