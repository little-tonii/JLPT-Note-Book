import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/create_lesson_by_level_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_state.dart';

class CreateLessonCubit extends Cubit<CreateLessonState> {
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();
  final CreateLessonByLevelIdUsecase _createLessonByLevelIdUsecase =
      getIt<CreateLessonByLevelIdUsecase>();

  CreateLessonCubit() : super(CreateLessonInitial());

  void init({required String levelId}) {
    emit(CreateLessonLoaded(levelId: levelId));
  }

  void createNewLesson({required String lesson}) async {
    if (state is CreateLessonLoaded) {
      final currentState = state as CreateLessonLoaded;
      String levelId = currentState.levelId;
      emit(CreateLessonLoading());
      final lessonResult = await _createLessonByLevelIdUsecase.call(
        levelId: levelId,
        lesson: lesson,
      );
      lessonResult.fold(
        (failure) async {
          await _createAdminLogUsecase.call(
            message: failure.message,
            action: "CREATE",
            actionStatus: "FAILED",
          );
          emit(CreateLessonFailure(message: failure.message));
        },
        (success) async {
          String message = 'Tạo mới bài học thành công';
          await _createAdminLogUsecase.call(
            action: 'CREATE',
            actionStatus: "SUCCESS",
            message: '${success.id} | $message',
          );
          emit(CreateLessonSuccess(message: message, lesson: success));
        },
      );
    }
  }
}
