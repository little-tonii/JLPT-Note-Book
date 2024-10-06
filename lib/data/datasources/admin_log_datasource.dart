import 'package:note_book_app/data/models/admin_log_model.dart';

abstract class AdminLogDatasource {
  Future<List<AdminLogModel>> getAdminLogs({
    required int pageNumber,
    required int pageSize,
    required String filterType,
  });

  Future<bool> createAdminLog({
    required String message,
    required String action,
    required String actionStatus,
  });
}
