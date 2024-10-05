import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';

class UpdateOnyomiByKanjiIdUsecase {
  final OnyomiRepository onyomiRepository;

  const UpdateOnyomiByKanjiIdUsecase({required this.onyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
    required String onyomiId,
  }) async {
    return await onyomiRepository.updateOnyomiByKanjiId(
      kanjiId: kanjiId,
      meaning: meaning,
      sample: sample,
      transform: transform,
      onyomiId: onyomiId,
    );
  }
}
