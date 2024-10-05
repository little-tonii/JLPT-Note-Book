import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class UpdateKanjiByIdUsecase {
  final KanjiRepository kanjiRepository;

  const UpdateKanjiByIdUsecase({required this.kanjiRepository});

  Future<Either<Failure, bool>> call({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) async {
    return await kanjiRepository.updateKanjiById(
      id: id,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
    );
  }
}
