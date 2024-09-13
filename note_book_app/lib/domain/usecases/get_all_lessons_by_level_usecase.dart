import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class GetAllLessonsByLevelUsecase {
  final LessonRepository lessonRepository;

  const GetAllLessonsByLevelUsecase({required this.lessonRepository});

  Future<Either<Failure, List<LessonEntity>>> call({
    required String level,
  }) async {
    return await lessonRepository.getAllLessonsByLevel(level: level);
  }
}
