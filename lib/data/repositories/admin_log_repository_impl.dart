import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/core/failures/unknown_failure.dart';
import 'package:note_book_app/data/datasources/admin_log_datasource.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';
import 'package:note_book_app/domain/repositories/admin_log_repository.dart';

class AdminLogRepositoryImpl implements AdminLogRepository {
  final AdminLogDatasource adminLogDatasource;

  const AdminLogRepositoryImpl({required this.adminLogDatasource});

  @override
  Future<Either<Failure, bool>> createAdminLog(
      {required String message}) async {
    try {
      final result = await adminLogDatasource.createAdminLog(message: message);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<AdminLogEntity>>> getAdminLogs(
      {required int pageNumber, required int pageSize}) async {
    try {
      final result = await adminLogDatasource.getAdminLogs(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
