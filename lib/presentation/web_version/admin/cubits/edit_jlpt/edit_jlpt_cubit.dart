import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/update_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jlpt/edit_jlpt_state.dart';

class EditJlptCubit extends Cubit<EditJlptState> {
  final UpdateLevelByIdUsecase _updateLevelByIdUsecase =
      getIt<UpdateLevelByIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  EditJlptCubit() : super(EditJlptInitial());

  void init() {
    emit(EditJlptLoaded());
  }

  void updateJlpt({required String id, required String level}) async {
    if (state is EditJlptLoaded) {
      emit(EditJlptLoading());
      final result = await _updateLevelByIdUsecase.call(id: id, level: level);
      result.fold(
        (failure) async {
          await _createAdminLogUsecase.call(
            action: "UPDATE",
            actionStatus: "FAILED",
            message: '$id | ${failure.message}',
          );
          emit(EditJlptFailure(message: failure.message));
        },
        (success) async {
          String message = 'Cập nhật JLPT thành công';
          await _createAdminLogUsecase.call(
            action: "UPDATE",
            actionStatus: "SUCCESS",
            message: '$id | $message',
          );
          emit(EditJlptSuccess(message: message, level: success));
        },
      );
    }
  }
}
