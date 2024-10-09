import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class LevelRepository {
  Future<Either<Failure, List<LevelEntity>>> getAllLevels();
  Future<Either<Failure, LevelEntity>> getLevelById({required String id});
  Future<Either<Failure, LevelEntity>> createLevel({required String level});
}
