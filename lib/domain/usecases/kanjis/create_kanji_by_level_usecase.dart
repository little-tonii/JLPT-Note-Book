import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class CreateKanjiByLevelUsecase {
  final KanjiRepository kanjiRepository;

  const CreateKanjiByLevelUsecase({required this.kanjiRepository});

  Future<Either<Failure, bool>> call({
    required String level,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    return await kanjiRepository.createKanjjByLevel(
      level: level,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
    );
  }
}
