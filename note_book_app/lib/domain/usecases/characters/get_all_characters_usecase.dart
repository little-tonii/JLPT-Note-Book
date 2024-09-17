import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';

class GetAllCharactersUsecase {
  final CharacterRepository characterRepository;

  const GetAllCharactersUsecase({required this.characterRepository});

  Future<Either<Failure, List<CharacterEntity>>> call() async {
    return await characterRepository.getAllCharacters();
  }
}
