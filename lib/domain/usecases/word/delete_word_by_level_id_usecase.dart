import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class DeleteWordByLevelIdUsecase {
  final WordRepository wordRepository;

  const DeleteWordByLevelIdUsecase({required this.wordRepository});

  Future<Either<Failure, int>> call({required String levelId}) async {
    return await wordRepository.deleteWordByLevelId(levelId: levelId);
  }
}
