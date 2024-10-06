import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/get_admin_logs_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_log_manager/admin_log_manager_state.dart';

class AdminLogManagerCubit extends Cubit<AdminLogManagerState> {
  final GetAdminLogsUsecase _getAdminLogsUsecase = getIt<GetAdminLogsUsecase>();

  AdminLogManagerCubit() : super(AdminLogManagerInitial());

  void getAdminLogs({
    required String filterType,
  }) async {
    final currentState = state;
    final isInitialState = currentState is AdminLogManagerInitial;
    final currentLogs = isInitialState
        ? currentState.logs
        : (currentState as AdminLogManagerLoaded).logs;
    final currentPageNumber = isInitialState
        ? currentState.pageNumber
        : (currentState as AdminLogManagerLoaded).pageNumber;
    final currentPageSize = isInitialState
        ? currentState.pageSize
        : (currentState as AdminLogManagerLoaded).pageSize;
    final currentHasReachedMax = isInitialState
        ? currentState.hasReachedMax
        : (currentState as AdminLogManagerLoaded).hasReachedMax;

    if (currentHasReachedMax) return;

    final nextPageNumber = currentPageNumber + 1;

    final result = await _getAdminLogsUsecase(
      filterType: filterType,
      pageNumber: nextPageNumber,
      pageSize: currentPageSize,
    );

    result.fold(
      (failure) => emit(AdminLogManagerFailure(message: failure.message)),
      (newLogs) {
        final isLastPage = newLogs.length < currentPageSize;
        final updatedLogs = [...currentLogs, ...newLogs];
        emit(AdminLogManagerLoaded(
          logs: updatedLogs,
          filterType: filterType,
          pageNumber: nextPageNumber,
          pageSize: currentPageSize,
          hasReachedMax: isLastPage,
        ));
      },
    );
  }

  void resetState() {
    emit(AdminLogManagerInitial());
  }
}
