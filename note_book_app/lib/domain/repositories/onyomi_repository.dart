import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';

abstract class OnyomiRepository {
  Future<Either<Failure, List<OnyomiEntity>>> getAllOnyomisByKanjiId({required String kanjiId});
}