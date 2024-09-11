import 'package:dartz/dartz.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class LevelRepository {
  Future<Either<Exception, List<LevelEntity>>> getAllLevels();
}
