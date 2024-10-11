import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class CreateWordByLevelIdAndLessonIdUsecase {
  final WordRepository wordRepository;

  const CreateWordByLevelIdAndLessonIdUsecase({required this.wordRepository});

  Future<Either<Failure, WordEntity>> call({
    required String levelId,
    required String lessonId,
    required String word,
    required String meaning,
    required String kanjiForm,
  }) async {
    return await wordRepository.createWordByLevelIdAndLessonId(
      levelId: levelId,
      lessonId: lessonId,
      word: word,
      meaning: meaning,
      kanjiForm: kanjiForm,
    );
  }
}
