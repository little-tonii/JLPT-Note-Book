import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class CreateLessonByLevelIdUsecase {
  final LessonRepository lessonRepository;

  const CreateLessonByLevelIdUsecase({required this.lessonRepository});

  Future<Either<Failure, LessonEntity>> call(
      {required String levelId, required String lesson}) async {
    return await lessonRepository.createLessonByLevelId(
        levelId: levelId, lesson: lesson);
  }
}
