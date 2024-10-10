import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class UpdateLevelByIdUsecase {
  final LevelRepository levelRepository;

  const UpdateLevelByIdUsecase({required this.levelRepository});

  Future<Either<Failure, LevelEntity>> call(
      {required String id, required String level}) async {
    return await levelRepository.updateLevelById(id: id, level: level);
  }
}
