import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class GetAllLessonsByLevelIdUsecase {
  final LessonRepository lessonRepository;

  const GetAllLessonsByLevelIdUsecase({required this.lessonRepository});

  Future<Either<Failure, List<LessonEntity>>> call({
    required String levelId,
  }) async {
    return await lessonRepository.getAllLessonsByLevelId(
      levelId: levelId,
    );
  }
}
