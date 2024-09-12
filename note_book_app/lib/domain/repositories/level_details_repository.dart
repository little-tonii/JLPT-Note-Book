import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_details_entity.dart';

abstract class LevelDetailsRepository {
  Future<Either<Failure, List<LevelDetailsEntity>>> getAllLevelDetails({
    required String level,
  });
}
