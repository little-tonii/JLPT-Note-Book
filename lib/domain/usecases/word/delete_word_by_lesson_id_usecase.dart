import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class DeleteWordByLessonIdUsecase {
  final WordRepository wordRepository;

  const DeleteWordByLessonIdUsecase({required this.wordRepository});

  Future<Either<Failure, int>> call({required String lessonId}) async {
    return await wordRepository.deleteWordByLessonId(lessonId: lessonId);
  }
}
