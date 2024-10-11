import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class DeleteWordByIdUsecase {
  final WordRepository wordRepository;

  const DeleteWordByIdUsecase({required this.wordRepository});

  Future<Either<Failure, WordEntity>> call({required String id}) async {
    return await wordRepository.deleteWordById(id: id);
  }
}