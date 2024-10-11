import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/delete_lesson_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/word/delete_word_by_lesson_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_lesson/delete_lesson_state.dart';

class DeleteLessonCubit extends Cubit<DeleteLessonState> {
  final DeleteLessonByIdUsecase _deleteLessonByIdUsecase =
      getIt<DeleteLessonByIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();
  final DeleteWordByLessonIdUsecase _deleteWordByLessonIdUsecase =
      getIt<DeleteWordByLessonIdUsecase>();

  DeleteLessonCubit() : super(DeleteLessonInitial());

  void init() {
    emit(DeleteLessonLoaded());
  }

  void deleteLesson({required String id}) async {
    emit(DeleteLessonLoading());
    final deletedLesson = await _deleteLessonByIdUsecase.call(id: id);
    int numWordsDeleted = 0;
    bool isContinue = true;
    final wordsDeletedByLessonId =
        await _deleteWordByLessonIdUsecase.call(lessonId: id);
    wordsDeletedByLessonId.fold(
      (failure) async {
        isContinue = false;
        await _createAdminLogUsecase.call(
          message: '$id | ${failure.message}',
          action: "DELETE",
          actionStatus: "FAILED",
        );
        emit(DeleteLessonFailure(message: failure.message));
      },
      (success) async {
        numWordsDeleted = success;
      },
    );
    if (isContinue) {
      deletedLesson.fold((failure) async {
        await _createAdminLogUsecase.call(
          message: '$id | ${failure.message}',
          action: "DELETE",
          actionStatus: "FAILED",
        );
        emit(DeleteLessonFailure(message: failure.message));
      }, (success) async {
        String message = 'Xóa bài học thành công';
        await _createAdminLogUsecase.call(
          message:
              '{ id: "${success.id}", lesson: "${success.lesson}", createdAt: "${success.createdAt.toDate().toLocal().toString()}", levelId: "${success.levelId}" } | $message. Số từ vựng đã xóa: $numWordsDeleted.',
          action: "DELETE",
          actionStatus: "SUCCESS",
        );
        emit(DeleteLessonSuccess(message: message, lessonId: id));
      });
    }
  }
}
