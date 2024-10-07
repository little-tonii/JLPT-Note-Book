import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';

class DeleteKunyomiByKanjiIdUsecase {
  final KunyomiRepository kunyomiRepository;

  const DeleteKunyomiByKanjiIdUsecase({required this.kunyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String kunyomiId,
  }) async {
    return await kunyomiRepository.deleteKunyomiByKanjiId(
      kanjiId: kanjiId,
      kunyomiId: kunyomiId,
    );
  }
}
