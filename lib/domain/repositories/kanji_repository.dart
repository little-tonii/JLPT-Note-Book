import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

abstract class KanjiRepository {
  Future<Either<Failure, List<KanjiEntity>>> getAllKanjisByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  });

  Future<Either<Failure, KanjiEntity>> createKanjjByLevelId({
    required String levelId,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  });

  Future<Either<Failure, bool>> updateKanjiById({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  });

  Future<Either<Failure, bool>> deleteKanjiById({required String id});
}
