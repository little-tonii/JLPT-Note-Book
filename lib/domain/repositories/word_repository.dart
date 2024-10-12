import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';

abstract class WordRepository {
  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String searchKey,
  });

  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelIdAndLessonId({
    required String lessonId,
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String searchKey,
  });

  Future<Either<Failure, WordEntity>> createWordByLevelIdAndLessonId({
    required String levelId,
    required String lessonId,
    required String word,
    required String meaning,
    required String kanjiForm,
  });

  Future<Either<Failure, WordEntity>> updateWordById({
    required String id,
    required String word,
    required String meaning,
    required String kanjiForm,
  });

  Future<Either<Failure, WordEntity>> deleteWordById({required String id});

  Future<Either<Failure, int>> deleteWordByLevelId({required String levelId});

  Future<Either<Failure, int>> deleteWordByLessonId({required String lessonId});
}
