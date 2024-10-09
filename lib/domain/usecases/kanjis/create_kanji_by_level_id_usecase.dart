import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class CreateKanjiByLevelIdUsecase {
  final KanjiRepository kanjiRepository;

  const CreateKanjiByLevelIdUsecase({required this.kanjiRepository});

  Future<Either<Failure, KanjiEntity>> call({
    required String levelId,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    return await kanjiRepository.createKanjjByLevelId(
      levelId: levelId,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
    );
  }
}
