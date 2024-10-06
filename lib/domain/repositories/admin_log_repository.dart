import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';

abstract class AdminLogRepository {
  Future<Either<Failure, List<AdminLogEntity>>> getAdminLogs({
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<Failure, bool>> createAdminLog({required String message});
}
