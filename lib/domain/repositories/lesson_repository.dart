import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class LessonRepository {
  Future<Either<Failure, List<LessonEntity>>> getAllLessonsByLevelId(
      {required String levelId});
  Future<Either<Failure, LessonEntity>> getLessonById({required String id});
}
