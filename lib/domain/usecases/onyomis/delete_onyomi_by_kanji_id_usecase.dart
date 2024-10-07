import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';

class DeleteOnyomiByKanjiIdUsecase {
  final OnyomiRepository onyomiRepository;

  const DeleteOnyomiByKanjiIdUsecase({required this.onyomiRepository});

  Future<Either<Failure, bool>> call({
    required String kanjiId,
    required String onyomiId,
  }) async {
    return await onyomiRepository.deleteOnyomiByKanjiId(
      kanjiId: kanjiId,
      onyomiId: onyomiId,
    );
  }
}
