import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/update_lesson_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_lesson/edit_lesson_state.dart';

class EditLessonCubit extends Cubit<EditLessonState> {
  final UpdateLessonByIdUsecase _updateLessonByIdUsecase =
      getIt<UpdateLessonByIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  EditLessonCubit() : super(EditLessonInitial());

  void init({required String id, required String lesson}) {
    emit(EditLessonLoaded(id: id, lesson: lesson));
  }

  void saveChange({required String lesson}) async {
    if (state is EditLessonLoaded) {
      final currentState = state as EditLessonLoaded;
      emit(EditLessonLoading());
      final editedLesson = await _updateLessonByIdUsecase.call(
        id: currentState.id,
        lesson: lesson,
      );
      editedLesson.fold((failure) async {
        await _createAdminLogUsecase.call(
          message: '${currentState.id} | ${failure.message}',
          action: "UPDATE",
          actionStatus: "FAILED",
        );
        emit(EditLessonFailure(message: failure.message));
      }, (success) async {
        String message = 'Cập nhật bài học thành công';
        await _createAdminLogUsecase.call(
          message: '${currentState.id} | $message',
          action: "UPDATE",
          actionStatus: "SUCCESS",
        );
        emit(EditLessonSuccess(message: message, lesson: success));
      });
    }
  }
}
