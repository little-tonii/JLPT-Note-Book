import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_state.dart';

class LevelPageWebCubit extends Cubit<LevelPageWebState> {
  final GetAllLessonsByLevelIdUsecase _getAllLessonsByLevelIdUsecase =
      getIt<GetAllLessonsByLevelIdUsecase>();
  final GetLevelByIdUsecase _getLevelByIdUsecase = getIt<GetLevelByIdUsecase>();

  LevelPageWebCubit() : super(LevelPageWebInitial());

  void initPageTitle({required String levelId}) async {
    final level = await _getLevelByIdUsecase.call(id: levelId);
    level.fold(
      (failure) => emit(LevelPageWebFailure(failureMessage: failure.message)),
      (level) => emit(LevelPageWebTitle(level: level)),
    );
  }

  void getAllLessonsByLevelId({required String levelId}) async {
    if (state is LevelPageWebTitle) {
      final currentState = state as LevelPageWebTitle;
      final level = currentState.level;
      emit(LevelPageWebLoading());
      final result =
          await _getAllLessonsByLevelIdUsecase.call(levelId: levelId);

      result.fold(
        (failure) => emit(LevelPageWebFailure(failureMessage: failure.message)),
        (lessons) => emit(LevelPageWebLoaded(lessons: lessons, level: level)),
      );
    }
  }
}
