import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/delete_kanjis_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/delete_lesson_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/delete_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jnpt/delete_jnpt_state.dart';

class DeleteJnptCubit extends Cubit<DeleteJnptState> {
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();
  final DeleteLevelByIdUsecase _deleteLevelByIdUsecase =
      getIt<DeleteLevelByIdUsecase>();
  final DeleteKanjisByLevelIdUsecase _deleteKanjisByLevelIdUsecase =
      getIt<DeleteKanjisByLevelIdUsecase>();
  final DeleteLessonByLevelIdUsecase _deleteLessonByLevelIdUsecase =
      getIt<DeleteLessonByLevelIdUsecase>();

  DeleteJnptCubit() : super(DeleteJnptInitial());

  void init() {
    emit(DeleteJnptLoaded());
  }

  void deleteJnpt({required LevelEntity jnpt}) async {
    if (state is DeleteJnptLoaded) {
      bool isContinue = true;
      int numKanjisDeleted = 0;
      int numLessonsDeleted = 0;
      emit(DeleteJnptLoading());
      final kanjisDeleted =
          await _deleteKanjisByLevelIdUsecase.call(levelId: jnpt.id);
      kanjisDeleted.fold((failure) async {
        isContinue = false;
        await _createAdminLogUsecase.call(
          action: 'DELETE',
          actionStatus: 'FAILED',
          message: failure.message,
        );
        emit(DeleteJnptFailure(message: failure.message));
      }, (success) {
        numKanjisDeleted = success;
      });
      if (isContinue) {
        final lessonsDeleted =
            await _deleteLessonByLevelIdUsecase.call(levelId: jnpt.id);
        lessonsDeleted.fold((failure) async {
          isContinue = false;
          await _createAdminLogUsecase.call(
            action: 'DELETE',
            actionStatus: 'FAILED',
            message: failure.message,
          );
          emit(DeleteJnptFailure(message: failure.message));
        }, (success) {
          numLessonsDeleted = success;
        });
      }
      if (isContinue) {
        final result = await _deleteLevelByIdUsecase.call(levelId: jnpt.id);
        result.fold(
          (failure) async {
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'FAILED',
              message: failure.message,
            );
            emit(DeleteJnptFailure(message: failure.message));
          },
          (success) async {
            String message = 'Xóa JNPT thành công';
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'SUCCESS',
              message:
                  '{ id: ${jnpt.id}, level: ${jnpt.level}, createdAt: ${jnpt.createdAt.toDate().toLocal().toString()} } | $message. Số kanji đã xóa: $numKanjisDeleted. Số bài học đã xóa: $numLessonsDeleted',
            );
            emit(DeleteJnptSuccess(message: message, levelEntity: jnpt));
          },
        );
      }
    }
  }
}
