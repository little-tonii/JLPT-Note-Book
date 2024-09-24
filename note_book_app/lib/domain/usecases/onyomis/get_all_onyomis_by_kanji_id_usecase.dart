import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';

class GetAllOnyomisByKanjiIdUsecase {
  final OnyomiRepository onyomiRepository;

  const GetAllOnyomisByKanjiIdUsecase({required this.onyomiRepository});

  Future<Either<Failure, List<OnyomiEntity>>> call(
      {required String kanjiId}) async {
    return await onyomiRepository.getAllOnyomisByKanjiId(kanjiId: kanjiId);
  }
}