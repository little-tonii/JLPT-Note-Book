import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';

class CreateKunyomiByKanjiIdUsecase {
  final KunyomiRepository kunyomiRepository;

  const CreateKunyomiByKanjiIdUsecase({required this.kunyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String meaning,
    required String sample,
    required String transform,
  }) async {
    return await kunyomiRepository.createKunyomiByKanjiId(
      kanjiId: kanjiId,
      meaning: meaning,
      sample: sample,
      transform: transform,
    );
  }
}
