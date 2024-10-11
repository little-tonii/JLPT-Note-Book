import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/repositories/word_repository.dart';

class GetAllWordsByLevelIdUsecase {
  final WordRepository wordRepository;

  const GetAllWordsByLevelIdUsecase({required this.wordRepository});

  Future<Either<Failure, List<WordEntity>> > call({
    required String levelId,
    required int pageSize,
    required int pageNumber,
  }) async {
    return await wordRepository.getAllWordsByLevelId(
      levelId: levelId,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
  }
}