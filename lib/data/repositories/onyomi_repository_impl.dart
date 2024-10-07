import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/onyomi_datasource.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';

class OnyomiRepositoryImpl implements OnyomiRepository {
  final OnyomiDatasource onyomiDatasource;

  const OnyomiRepositoryImpl({required this.onyomiDatasource});

  @override
  Future<Either<Failure, List<OnyomiEntity>>> getAllOnyomisByKanjiId(
      {required String kanjiId}) async {
    try {
      final result =
          await onyomiDatasource.getAllOnyomisByKanjiId(kanjiId: kanjiId);
      return Right(result.map((onyomi) => onyomi.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createOnyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    try {
      return Right(await onyomiDatasource.createOnyomiByKanjiId(
        kanjiId: kanjiId,
        meaning: meaning,
        sample: sample,
        transform: transform,
      ));
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateOnyomiByKanjiId({
    required String kanjiId,
    required String onyomiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    try {
      return Right(await onyomiDatasource.updateOnyomiByKanjiId(
        kanjiId: kanjiId,
        onyomiId: onyomiId,
        meaning: meaning,
        sample: sample,
        transform: transform,
      ));
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOnyomiByKanjiId(
      {required String kanjiId, required String onyomiId}) async {
    try {
      return Right(await onyomiDatasource.deleteOnyomiByKanjiId(
        kanjiId: kanjiId,
        onyomiId: onyomiId,
      ));
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
