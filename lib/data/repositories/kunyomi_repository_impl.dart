import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/kunyomi_datasource.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';

class KunyomiRepositoryImpl implements KunyomiRepository {
  final KunyomiDatasource kunyomiDatasource;

  const KunyomiRepositoryImpl({required this.kunyomiDatasource});

  @override
  Future<Either<Failure, List<KunyomiEntity>>> getAllKunyomisByKanjiId(
      {required String kanjiId}) async {
    try {
      final result =
          await kunyomiDatasource.getAllKunyomisByKanjiId(kanjiId: kanjiId);
      return Right(result.map((kunyomi) => kunyomi.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createKunyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    try {
      return Right(await kunyomiDatasource.createKunyomiByKanjiId(
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
  Future<Either<Failure, bool>> updateKunyomiByKanjiId({
    required String kanjiId,
    required String kunyomiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    try {
      return Right(await kunyomiDatasource.updateKunyomiByKanjiId(
        kanjiId: kanjiId,
        kunyomiId: kunyomiId,
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
}
