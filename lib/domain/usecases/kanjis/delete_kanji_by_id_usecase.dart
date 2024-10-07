import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class DeleteKanjiByIdUsecase {
  final KanjiRepository kanjiRepository;

  const DeleteKanjiByIdUsecase({required this.kanjiRepository});

  Future<Either<Failure, bool>> call({required String id}) async {
    return await kanjiRepository.deleteKanjiById(id: id);
  }
}
