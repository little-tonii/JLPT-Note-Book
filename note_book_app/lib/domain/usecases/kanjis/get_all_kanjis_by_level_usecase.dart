import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';

class GetAllKanjisByLevelUsecase {
  final KanjiRepository kanjiRepository;

  const GetAllKanjisByLevelUsecase({required this.kanjiRepository});

  Future<Either<Failure, List<KanjiEntity>>> call({
    required String level,
    required int pageSize,
    required int pageNumber,
    required String hanVietSearchKey,
  }) async {
    return await kanjiRepository.getAllKanjisByLevel(
      level: level,
      pageNumber: pageNumber,
      pageSize: pageSize,
      hanVietSearchKey: hanVietSearchKey,
    );
  }
}
