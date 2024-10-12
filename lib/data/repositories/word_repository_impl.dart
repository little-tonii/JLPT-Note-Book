import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/invalid_parameter_failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/word_datasource.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
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

  @override
  Future<Either<Failure, List<QuestionEntity>>> createWordQuestions({
    required String questionType,
    required String answerType,
    required String levelId,
    required String lessonId,
  }) async {
    try {
      if (questionType != 'kanjiForm' &&
          questionType != 'meaning' &&
          questionType != 'word') {
        return Left(InvalidParameterFailure());
      }
      if (answerType != 'kanjiForm' &&
          answerType != 'meaning' &&
          answerType != 'word') {
        return Left(InvalidParameterFailure());
      }
      final words = await wordDatasource.createWordQuestions(
        questionType: questionType,
        answerType: answerType,
        levelId: levelId,
        lessonId: lessonId,
      )
        ..shuffle();
      List<QuestionEntity> questions = [];
      List<String> answers = words.map((e) {
        if (answerType == 'word') {
          return e.word;
        } else if (answerType == 'kanjiForm') {
          return e.kanjiForm;
        } else {
          return e.meaning;
        }
      }).toList();
      for (var word in words) {
        final question = questionType == 'word'
            ? word.word
            : questionType == 'kanjiForm'
                ? word.kanjiForm
                : word.meaning;
        final correctAnswer = answerType == 'word'
            ? word.word
            : answerType == 'kanjiForm'
                ? word.kanjiForm
                : word.meaning;
        final wrongAnswers = List.of(answers);
        wrongAnswers.remove(correctAnswer);
        wrongAnswers.shuffle();

        questions.add(QuestionEntity(
          question: question,
          correctAnswer: correctAnswer,
          answers: [correctAnswer, ...wrongAnswers.take(3)]..shuffle(),
        ));
      }
      return Right(questions..shuffle());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
