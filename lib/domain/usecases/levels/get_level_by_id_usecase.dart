import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';

class GetLevelByIdUsecase {
  final LevelRepository levelRepository;

  const GetLevelByIdUsecase({required this.levelRepository});

  Future<Either<Failure, LevelEntity>> call({required String id}) async {
    return await levelRepository.getLevelById(id: id);
  }
}
