import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/create_level_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jlpt/create_new_jlpt_state.dart';

class CreateNewJlptCubit extends Cubit<CreateNewJlptState> {
  final CreateLevelUsecase _createLevelUsecase = getIt<CreateLevelUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  CreateNewJlptCubit() : super(CreateNewJlptInitial());

  void init() {
    emit(CreateNewJlptLoaded());
  }

  void createNewJlpt({required String level}) async {
    emit(CreateNewJlptLoading());
    final result = await _createLevelUsecase.call(level: level);
    result.fold(
      (failure) async {
        await _createAdminLogUsecase.call(
          message: failure.message,
          action: "CREATE",
          actionStatus: "FAILED",
        );
        emit(CreateNewJlptFailure(message: failure.message));
      },
      (success) async {
        String message = 'Tạo mới JLPT thành công';
        await _createAdminLogUsecase.call(
          action: 'CREATE',
          actionStatus: "SUCCESS",
          message: '${success.id} | $message',
        );
        emit(CreateNewJlptSuccess(message: message, levelEntity: success));
      },
    );
  }
}
