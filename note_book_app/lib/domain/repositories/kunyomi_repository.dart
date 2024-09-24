import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';

abstract class KunyomiRepository {
  Future<Either<Failure, List<KunyomiEntity>>> getAllKunyomisByKanjiId({required String kanjiId});
}