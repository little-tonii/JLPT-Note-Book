import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class GetAllLevelsUsecase {
  final LevelRepository levelRepository;

  const GetAllLevelsUsecase({required this.levelRepository});

  Future<Either<Failure, List<LevelEntity>>> call() async {
    return await levelRepository.getAllLevels();
  }
}
