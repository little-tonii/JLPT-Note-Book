import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource characterDatasource;

  const CharacterRepositoryImpl({required this.characterDatasource});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters() async {
    try {
      final characters = await characterDatasource.getAllCharacters();
      return Right(
          characters.map((character) => character.toEntity()).toList());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> createCharacterQuestions({
    required int numberOfQuestions,
    required String questionType,
    required String answerType,
  }) async {
    try {
      final characters = (await characterDatasource.getAllCharacters())
          .where((character) => character.romanji.trim().isNotEmpty)
          .toList();
      if (numberOfQuestions > characters.length) {
        return Left(UnknownFailure());
            // TooManyQuestionFailure(
            //     message:
            //         "Hãy chọn bằng hoặc ít hơn ${characters.length} câu hỏi"),
            // );
      }
      List<QuestionEntity> questions = [];
      final random = Random();
      while (numberOfQuestions-- > 0) {
        int index = -1;
        String question = '';
        do {
          index = random.nextInt(characters.length);
          question =
              "Chọn ${answerType.toLowerCase()} đúng của chữ cái ${questionType.toLowerCase()} ${questionType == 'Hiragana' ? characters[index].hiragana : questionType == 'Katakana' ? characters[index].katakana : characters[index].romanji}:";
        } while (questions
            .where((element) => element.question == question)
            .isNotEmpty);
        List<String> wrongAnswers = [];
        do {
          int choosedIndex = random.nextInt(characters.length);
          if (choosedIndex == index) {
            continue;
          }
          String wrongAnswer = answerType == 'Hiragana'
              ? characters[choosedIndex].hiragana
              : answerType == 'Katakana'
                  ? characters[choosedIndex].katakana
                  : characters[choosedIndex].romanji;
          if (!wrongAnswers.contains(wrongAnswer)) {
            wrongAnswers.add(wrongAnswer);
          }
        } while (wrongAnswers.length < 3);
        final newQuestion = QuestionEntity(
          question: question,
          correctAnswer: answerType == 'Hiragana'
              ? characters[index].hiragana
              : answerType == 'Katakana'
                  ? characters[index].katakana
                  : characters[index].romanji,
          answers: [
            answerType == 'Hiragana'
                ? characters[index].hiragana
                : answerType == 'Katakana'
                    ? characters[index].katakana
                    : characters[index].romanji,
            ...wrongAnswers,
          ]..shuffle(),
        );
        questions.add(newQuestion);
      }
      return Right(questions);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
