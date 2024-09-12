import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/data/datasources/level_details_datasource.dart';
import 'package:note_book_app/domain/entities/level_details_entity.dart';
import 'package:note_book_app/domain/repositories/level_details_repository.dart';

class LevelDetailsRepositoryImpl implements LevelDetailsRepository {
  final LevelDetailsDatasource levelDetailsDatasource;

  const LevelDetailsRepositoryImpl({required this.levelDetailsDatasource});

  @override
  Future<Either<Failure, List<LevelDetailsEntity>>> getAllLevelDetails(
      {required String level}) async {
    try {
      final result =
          await levelDetailsDatasource.getAllLevelDetails(level: level);
      return Right(
        result.map((levelDetails) => levelDetails.toEntity()).toList(),
      );
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
