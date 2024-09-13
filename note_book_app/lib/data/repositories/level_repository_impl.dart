import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class LevelRepositoryImpl implements LevelRepository {
  final LevelDatasource levelDatasource;

  const LevelRepositoryImpl({required this.levelDatasource});

  @override
  Future<Either<Failure, List<LevelEntity>>> getAllLevels() async {
    try {
      final result = await levelDatasource.getAllLevels();
      return Right(result.map((level) => level.toEntity()).toList());
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
