import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';

class CreateCharacterQuestionUsecase {
  final CharacterRepository characterRepository;

  const CreateCharacterQuestionUsecase({required this.characterRepository});

  Future<Either<Failure, List<QuestionEntity>>> call({
    required int numberOfQuestions,
    required String questionType,
    required String answerType,
  }) async {
    return await characterRepository.createCharacterQuestions(
      numberOfQuestions: numberOfQuestions,
      questionType: questionType,
      answerType: answerType,
    );
  }
}
