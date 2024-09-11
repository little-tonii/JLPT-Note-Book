import 'package:dartz/dartz.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class GetAllLevelsUsecase {
  final LevelRepository _levelRepository;

  const GetAllLevelsUsecase(this._levelRepository);

  Future<Either<Exception, List<LevelEntity>>> call() async {
    return await _levelRepository.getAllLevels();
  }
}
