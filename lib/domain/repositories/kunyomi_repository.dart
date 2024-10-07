import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';

abstract class KunyomiRepository {
  Future<Either<Failure, List<KunyomiEntity>>> getAllKunyomisByKanjiId(
      {required String kanjiId});

  Future<Either<Failure, bool>> createKunyomiByKanjiId({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  });

  Future<Either<Failure, bool>> updateKunyomiByKanjiId({
    required String kanjiId,
    required String kunyomiId,
    required String meaning,
    required String sample,
    required String transform,
  });

  Future<Either<Failure, bool>> deleteKunyomiByKanjiId({
    required String kanjiId,
    required String kunyomiId,
  });
}
