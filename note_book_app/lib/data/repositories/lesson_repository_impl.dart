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
  Future<Either<Failure, List<LessonEntity>>> getAllLessonsByLevel(
      {required String level}) async {
    try {
      final result = await lessonDatasource.getAllLessonsByLevel(level: level);
      return Right(
        result.map((lesson) => lesson.toEntity()).toList(),
      );
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
