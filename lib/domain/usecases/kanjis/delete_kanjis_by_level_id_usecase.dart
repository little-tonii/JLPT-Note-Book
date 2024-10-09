import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class DeleteKanjisByLevelIdUsecase {
  final KanjiRepository kanjiRepository;

  const DeleteKanjisByLevelIdUsecase({required this.kanjiRepository});

  Future<Either<Failure, int>> call({
    required String levelId,
  }) async {
    return await kanjiRepository.deleteKanjisByLevelId(
      levelId: levelId,
    );
  }
}
