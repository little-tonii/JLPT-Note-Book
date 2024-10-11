import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/data/datasources/word_datasource.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class WordRepositoryImpl implements WordRepository {
  final WordDatasource wordDatasource;

  const WordRepositoryImpl({required this.wordDatasource});

  @override
  Future<Either<Failure, WordEntity>> deleteWordById({required String id}) {
    // TODO: implement deleteWordById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
  }) {
    // TODO: implement getAllWordsByLevelId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelIdAndLessonId({
    required String lessonId,
    required String levelId,
    required int pageSize,
    required int pageNumber,
  }) {
    // TODO: implement getAllWordsByLevelIdAndLessonId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, WordEntity>> updateWordById(
      {required String id,
      required String word,
      required String meaning,
      required String kanjiForm}) {
    // TODO: implement updateWordById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, WordEntity>> createWordByLevelIdAndLessonId(
      {required String levelId,
      required String lessonId,
      required String word,
      required String meaning,
      required String kanjiForm}) {
    // TODO: implement createWordByLevelIdAndLessonId
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, int>> deleteWordByLessonId({required String lessonId}) {
    // TODO: implement deleteWordByLessonId
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, int>> deleteWordByLevelId({required String levelId}) {
    // TODO: implement deleteWordByLevelId
    throw UnimplementedError();
  }
}
