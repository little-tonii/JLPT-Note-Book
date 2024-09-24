import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';

class GetAllKunyomisByKanjiIdUsecase {
  final KunyomiRepository kunyomiRepository;

  const GetAllKunyomisByKanjiIdUsecase({required this.kunyomiRepository});

  Future<Either<Failure, List<KunyomiEntity>>> call(
      {required String kanjiId}) async {
    return await kunyomiRepository.getAllKunyomisByKanjiId(kanjiId: kanjiId);
  }
}
