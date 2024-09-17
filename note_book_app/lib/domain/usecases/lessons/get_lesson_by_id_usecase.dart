import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';

class GetLessonByIdUsecase {
  final LessonRepository lessonRepository;

  const GetLessonByIdUsecase({required this.lessonRepository});

  Future<Either<Failure, LessonEntity>> call({required String id}) async {
    return await lessonRepository.getLessonById(id: id);
  }
}
