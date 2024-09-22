import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

abstract class KanjiRepository {
  Future<Either<Failure, List<KanjiEntity>>> getAllKanjisByLevel(
      {required String level});
}
