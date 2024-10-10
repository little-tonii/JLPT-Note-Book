import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/lesson_manager/lesson_manager_state.dart';

class LessonManagerCubit extends Cubit<LessonManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();
  final GetAllLessonsByLevelIdUsecase _getAllLessonsByLevelIdUsecase =
      getIt<GetAllLessonsByLevelIdUsecase>();

  LessonManagerCubit() : super(LessonManagerInitial());

  void init() async {
    final result = await _getAllLevelsUsecase.call();
    result.fold(
      (failure) {
        emit(LessonManagerFailure(message: failure.message));
      },
      (success) {
        emit(LessonManagerLoaded(
          levels: success,
          lessons: [],
          selectedLevelId: 'null',
        ));
      },
    );
  }

  void updateFilterChoice({required String levelId}) async {
    if (state is LessonManagerLoaded) {
      final lessons =
          await _getAllLessonsByLevelIdUsecase.call(levelId: levelId);
      lessons.fold(
        (failure) {
          emit(LessonManagerFailure(message: failure.message));
        },
        (success) {
          emit((state as LessonManagerLoaded).copyWith(
            lessons: success,
            selectedLevelId: levelId,
          ));
        },
      );
    }
  }

  void updateLessonListView({required LessonEntity lesson}) {
    if (state is LessonManagerLoaded) {
      final lessons = (state as LessonManagerLoaded).lessons;
      final updatedLessons = lessons.map((e) {
        if (e.id == lesson.id) {
          return lesson;
        }
        return e;
      }).toList();
      emit((state as LessonManagerLoaded).copyWith(lessons: updatedLessons));
    }
  }

  void addLessonListView({required LessonEntity lesson}) {
    if (state is LessonManagerLoaded) {
      final lessons = (state as LessonManagerLoaded).lessons;
      final updatedLessons = List<LessonEntity>.from(lessons)..add(lesson);
      emit((state as LessonManagerLoaded).copyWith(lessons: updatedLessons));
    }
  }

  void removeLessonListView({required String lessonId}) {
    if (state is LessonManagerLoaded) {
      final lessons = (state as LessonManagerLoaded).lessons;
      final updatedLessons = lessons.where((e) => e.id != lessonId).toList();
      emit((state as LessonManagerLoaded).copyWith(lessons: updatedLessons));
    }
  }
}
