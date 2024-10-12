import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class CreateWordQuestionUsecase {
  final WordRepository wordRepository;

  const CreateWordQuestionUsecase({required this.wordRepository});

  Future<Either<Failure, List<QuestionEntity>>> call({
    required String questionType,
    required String answerType,
    required String levelId,
    required String lessonId,
  }) async {
    return await wordRepository.createWordQuestions(
      questionType: questionType,
      answerType: answerType,
      levelId: levelId,
      lessonId: lessonId,
    );
  }
}
