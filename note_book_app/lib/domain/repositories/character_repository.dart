import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters();
}
