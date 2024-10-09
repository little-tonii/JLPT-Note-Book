import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonDatasource lessonDatasource;

  const LessonRepositoryImpl({required this.lessonDatasource});

  @override
  Future<Either<Failure, List<LessonEntity>>> getAllLessonsByLevelId(
      {required String levelId}) async {
    try {
      final result = await lessonDatasource.getAllLessonsByLevelId(
        levelId: levelId,
      );
      return Right(
        result.map((lesson) => lesson.toEntity()).toList(),
      );
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, LessonEntity>> getLessonById(
      {required String id}) async {
    try {
      final result = await lessonDatasource.getLessonById(id: id);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
