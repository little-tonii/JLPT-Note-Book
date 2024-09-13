import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource characterDatasource;

  const CharacterRepositoryImpl({required this.characterDatasource});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters() async {
    try {
      final characters = await characterDatasource.getAllCharacters();
      return Right(
          characters.map((character) => character.toEntity()).toList());
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
