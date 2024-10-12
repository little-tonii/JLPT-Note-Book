import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class GetAllWordsByLevelIdAndLessonIdUsecase {
  final WordRepository wordRepository;

  const GetAllWordsByLevelIdAndLessonIdUsecase({required this.wordRepository});

  Future<Either<Failure, List<WordEntity>>> call({
    required String levelId,
    required String lessonId,
    required int pageSize,
    required int pageNumber,
    required String searchKey,
  }) async {
    return await wordRepository.getAllWordsByLevelIdAndLessonId(
      levelId: levelId,
      lessonId: lessonId,
      pageSize: pageSize,
      pageNumber: pageNumber,
      searchKey: searchKey,
    );
  }
}
