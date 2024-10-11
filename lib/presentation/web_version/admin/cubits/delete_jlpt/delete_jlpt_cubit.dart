import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/delete_kanjis_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/delete_lesson_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/delete_level_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/word/delete_word_by_level_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jlpt/delete_jlpt_state.dart';

class DeleteJlptCubit extends Cubit<DeleteJlptState> {
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();
  final DeleteLevelByIdUsecase _deleteLevelByIdUsecase =
      getIt<DeleteLevelByIdUsecase>();
  final DeleteKanjisByLevelIdUsecase _deleteKanjisByLevelIdUsecase =
      getIt<DeleteKanjisByLevelIdUsecase>();
  final DeleteLessonByLevelIdUsecase _deleteLessonByLevelIdUsecase =
      getIt<DeleteLessonByLevelIdUsecase>();
  final DeleteWordByLevelIdUsecase _deleteWordByLevelIdUsecase =
      getIt<DeleteWordByLevelIdUsecase>();

  DeleteJlptCubit() : super(DeleteJlptInitial());

  void init() {
    emit(DeleteJlptLoaded());
  }

  void deleteJlpt({required LevelEntity jlpt}) async {
    if (state is DeleteJlptLoaded) {
      bool isContinue = true;
      int numKanjisDeleted = 0;
      int numLessonsDeleted = 0;
      int numWordsDeleted = 0;
      emit(DeleteJlptLoading());
      final kanjisDeleted =
          await _deleteKanjisByLevelIdUsecase.call(levelId: jlpt.id);
      kanjisDeleted.fold(
        (failure) async {
          isContinue = false;
          await _createAdminLogUsecase.call(
            action: 'DELETE',
            actionStatus: 'FAILED',
            message: '${jlpt.id} |${failure.message}',
          );
          emit(DeleteJlptFailure(message: failure.message));
        },
        (success) {
          numKanjisDeleted = success;
        },
      );
      if (isContinue) {
        final lessonsDeleted =
            await _deleteLessonByLevelIdUsecase.call(levelId: jlpt.id);
        lessonsDeleted.fold(
          (failure) async {
            isContinue = false;
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'FAILED',
              message: '${jlpt.id} | ${failure.message}',
            );
            emit(DeleteJlptFailure(message: failure.message));
          },
          (success) {
            numLessonsDeleted = success;
          },
        );
      }
      if (isContinue) {
        final wordsDeleted = await _deleteWordByLevelIdUsecase.call(
          levelId: jlpt.id,
        );
        wordsDeleted.fold(
          (failure) async {
            isContinue = false;
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'FAILED',
              message: '${jlpt.id} | ${failure.message}',
            );
            emit(DeleteJlptFailure(message: failure.message));
          },
          (success) {
            numWordsDeleted = success;
          },
        );
      }
      if (isContinue) {
        final result = await _deleteLevelByIdUsecase.call(levelId: jlpt.id);
        result.fold(
          (failure) async {
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'FAILED',
              message: '${jlpt.id} |${failure.message}',
            );
            emit(DeleteJlptFailure(message: failure.message));
          },
          (success) async {
            String message = 'Xóa JLPT thành công';
            await _createAdminLogUsecase.call(
              action: 'DELETE',
              actionStatus: 'SUCCESS',
              message:
                  '{ id: ${jlpt.id}, level: ${jlpt.level}, createdAt: ${jlpt.createdAt.toDate().toLocal().toString()} } | $message. Số kanji đã xóa: $numKanjisDeleted. Số bài học đã xóa: $numLessonsDeleted. Số từ vựng đã xóa: $numWordsDeleted.',
            );
            emit(DeleteJlptSuccess(message: message, levelEntity: jlpt));
          },
        );
      }
    }
  }
}
