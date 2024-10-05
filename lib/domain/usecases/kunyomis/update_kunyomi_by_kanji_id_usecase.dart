import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';

class UpdateKunyomiByKanjiIdUsecase {
  final KunyomiRepository kunyomiRepository;

  const UpdateKunyomiByKanjiIdUsecase({required this.kunyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
    required String kunyomiId,
  }) async {
    return await kunyomiRepository.updateKunyomiByKanjiId(
      kanjiId: kanjiId,
      meaning: meaning,
      sample: sample,
      transform: transform,
      kunyomiId: kunyomiId,
    );
  }
}
