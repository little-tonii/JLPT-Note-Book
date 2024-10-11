import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/word_datasource.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class WordRepositoryImpl implements WordRepository {
  final WordDatasource wordDatasource;

  const WordRepositoryImpl({required this.wordDatasource});

  @override
  Future<Either<Failure, WordEntity>> deleteWordById(
      {required String id}) async {
    try {
      final result = await wordDatasource.deleteWordById(id: id);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String searchKey,
  }) async {
    try {
      final result = await wordDatasource.getAllWordsByLevelId(
        levelId: levelId,
        pageSize: pageSize,
        pageNumber: pageNumber,
        searchKey: searchKey,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<WordEntity>>> getAllWordsByLevelIdAndLessonId({
    required String lessonId,
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String searchKey,
  }) async {
    try {
      final result = await wordDatasource.getAllWordsByLevelIdAndLessonId(
        lessonId: lessonId,
        levelId: levelId,
        pageSize: pageSize,
        pageNumber: pageNumber,
        searchKey: searchKey,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, WordEntity>> updateWordById({
    required String id,
    required String word,
    required String meaning,
    required String kanjiForm,
  }) async {
    try {
      final result = await wordDatasource.updateWordById(
        id: id,
        word: word,
        meaning: meaning,
        kanjiForm: kanjiForm,
      );
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, WordEntity>> createWordByLevelIdAndLessonId({
    required String levelId,
    required String lessonId,
    required String word,
    required String meaning,
    required String kanjiForm,
  }) async {
    try {
      final result = await wordDatasource.createWordByLevelIdAndLessonId(
        levelId: levelId,
        lessonId: lessonId,
        word: word,
        meaning: meaning,
        kanjiForm: kanjiForm,
      );
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteWordByLessonId(
      {required String lessonId}) async {
    try {
      final result =
          await wordDatasource.deleteWordByLessonId(lessonId: lessonId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteWordByLevelId(
      {required String levelId}) async {
    try {
      final result = await wordDatasource.deleteWordByLevelId(levelId: levelId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
