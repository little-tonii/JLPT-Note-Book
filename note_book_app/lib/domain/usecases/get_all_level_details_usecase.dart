import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/level_details_entity.dart';
import 'package:note_book_app/domain/repositories/level_details_repository.dart';

class GetAllLevelDetailsUsecase {
  final LevelDetailsRepository levelDetailsRepository;

  const GetAllLevelDetailsUsecase({required this.levelDetailsRepository});

  Future<Either<Failure, List<LevelDetailsEntity>>> call({
    required String level,
  }) async {
    return await levelDetailsRepository.getAllLevelDetails(level: level);
  }
}
