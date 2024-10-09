import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class DeleteLevelByIdUsecase {
  final LevelRepository levelRepository;

  const DeleteLevelByIdUsecase({required this.levelRepository});

  Future<Either<Failure, bool>> call({required String levelId}) async {
    return await levelRepository.deleteLevelById(id: levelId);
  }
}
