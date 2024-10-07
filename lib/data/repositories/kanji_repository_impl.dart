import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class KanjiRepositoryImpl implements KanjiRepository {
  final KanjiDatasource kanjiDatasource;

  const KanjiRepositoryImpl({required this.kanjiDatasource});

  @override
  Future<Either<Failure, List<KanjiEntity>>> getAllKanjisByLevel({
    required String level,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  }) async {
    try {
      final kanjis = await kanjiDatasource.getAllKanjisByLevel(
        level: level,
        pageSize: pageSize,
        pageNumber: pageNumber,
        hanVietSearchKey: hanVietSearchKey,
      );
      return Right(kanjis.map((kanji) => kanji.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, KanjiEntity>> createKanjjByLevel({
    required String level,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    try {
      final kanjiCreated = await kanjiDatasource.createKanjiByLevel(
        level: level,
        kanji: kanji,
        kun: kun,
        on: on,
        viet: viet,
      );
      return Right(kanjiCreated.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateKanjiById({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    try {
      return Right(await kanjiDatasource.updateKanjiById(
        id: id,
        kanji: kanji,
        kun: kun,
        on: on,
        viet: viet,
      ));
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteKanjiById({required String id}) async {
    try {
      return Right(await kanjiDatasource.deleteKanjiById(id: id));
    } on Failure catch (e) {
      return Left(e);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
