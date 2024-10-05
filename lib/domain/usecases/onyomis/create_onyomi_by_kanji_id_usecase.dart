import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';

class CreateOnyomiByKanjiIdUsecase {
  final OnyomiRepository onyomiRepository;

  const CreateOnyomiByKanjiIdUsecase({required this.onyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    return await onyomiRepository.createOnyomiByKanjiId(
      kanjiId: kanjiId,
      meaning: meaning,
      sample: sample,
      transform: transform,
    );
  }
}
