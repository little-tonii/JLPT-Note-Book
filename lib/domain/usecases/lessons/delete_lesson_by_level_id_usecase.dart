import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class DeleteLessonByLevelIdUsecase {
  final LessonRepository lessonRepository;

  const DeleteLessonByLevelIdUsecase({required this.lessonRepository});

  Future<Either<Failure, int>> call({
    required String levelId,
  }) async {
    return await lessonRepository.deleteLessonsByLevelId(
      levelId: levelId,
    );
  }
}
