import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

abstract class KanjiRepository {
  Future<Either<Failure, List<KanjiEntity>>> getAllKanjisByLevel({
    required String level,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  });

  Future<Either<Failure, KanjiEntity>> createKanjjByLevel({
    required String level,
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
}
