import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class GetAllKanjisByLevelIdUsecase {
  final KanjiRepository kanjiRepository;

  const GetAllKanjisByLevelIdUsecase({required this.kanjiRepository});

  Future<Either<Failure, List<KanjiEntity>>> call({
    required String levelId,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  }) async {
    return await kanjiRepository.getAllKanjisByLevelId(
      levelId: levelId,
      pageNumber: pageNumber,
      pageSize: pageSize,
      hanVietSearchKey: hanVietSearchKey,
    );
  }
}
