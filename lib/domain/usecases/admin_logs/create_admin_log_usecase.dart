import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/admin_log_repository.dart';

class CreateAdminLogUsecase {
  final AdminLogRepository adminLogRepository;

  const CreateAdminLogUsecase({required this.adminLogRepository});

  Future<Either<Failure, bool>> call({
    required String message,
    required String action,
    required String actionStatus,
  }) async {
    return await adminLogRepository.createAdminLog(
      message: message,
      action: action,
      actionStatus: actionStatus,
    );
  }
}
