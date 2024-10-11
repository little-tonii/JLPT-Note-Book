import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class UpdateWordByIdUsecase {
  final WordRepository wordRepository;

  const UpdateWordByIdUsecase({required this.wordRepository});

  Future<Either<Failure, WordEntity>> call({
    required String id,
    required String word,
    required String meaning,
    required String kanjiForm,
  }) async {
    return await wordRepository.updateWordById(
      id: id,
      word: word,
      meaning: meaning,
      kanjiForm: kanjiForm,
    );
  }
}
