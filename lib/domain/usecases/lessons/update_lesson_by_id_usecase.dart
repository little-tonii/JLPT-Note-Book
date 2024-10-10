import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class UpdateLessonByIdUsecase {
  final LessonRepository lessonRepository;

  const UpdateLessonByIdUsecase({required this.lessonRepository});

  Future<Either<Failure, LessonEntity>> call(
      {required String id, required String lesson}) async {
    return await lessonRepository.updateLessonById(id: id, lesson: lesson);
  }
}