import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';
import 'package:note_book_app/domain/repositories/admin_log_repository.dart';

class GetAdminLogsUsecase {
  final AdminLogRepository adminLogRepository;

  const GetAdminLogsUsecase({required this.adminLogRepository});

  Future<Either<Failure, List<AdminLogEntity>>> call(
      {required int pageNumber, required int pageSize}) async {
    return await adminLogRepository.getAdminLogs(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
