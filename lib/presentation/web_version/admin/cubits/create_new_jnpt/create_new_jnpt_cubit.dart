import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/create_level_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jnpt/create_new_jnpt_state.dart';

class CreateNewJnptCubit extends Cubit<CreateNewJnptState> {
  final CreateLevelUsecase _createLevelUsecase = getIt<CreateLevelUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  CreateNewJnptCubit() : super(CreateNewJnptInitial());

  void init() {
    emit(CreateNewJnptLoaded());
  }

  void createNewJnpt({required String level}) async {
    emit(CreateNewJnptLoading());
    final result = await _createLevelUsecase.call(level: level);
    result.fold(
      (failure) async {
        await _createAdminLogUsecase.call(
          message: failure.message,
          action: "CREATE",
          actionStatus: "FAILED",
        );
        emit(CreateNewJnptFailure(message: failure.message));
      },
      (success) async {
        String message = 'Tạo JNPT thành công';
        await _createAdminLogUsecase.call(
          action: 'CREATE',
          actionStatus: "SUCCESS",
          message: '${success.id} | $message',
        );
        emit(CreateNewJnptSuccess(message: message, levelEntity: success));
      },
    );
  }
}
