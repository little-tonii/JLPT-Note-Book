import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/levels/cubits/level_page_web_state.dart';

class LevelPageWebCubit extends Cubit<LevelPageWebState> {
  final GetAllLessonsByLevelUsecase _getAllLessonsByLevelUsecase =
      getIt<GetAllLessonsByLevelUsecase>();
  final GetLevelByIdUsecase _getLevelByIdUsecase = getIt<GetLevelByIdUsecase>();

  LevelPageWebCubit() : super(LevelPageWebInitial());

  void initPageTitle({required String levelId}) async {
    final level = await _getLevelByIdUsecase.call(id: levelId);
    level.fold(
      (failure) => emit(LevelPageWebFailure(failureMessage: failure.message)),
      (level) => emit(LevelPageWebTitle(title: level.level)),
    );
  }

  void getAllLessonsByLevel({required String level}) async {
    emit(LevelPageWebLoading());
    final result = await _getAllLessonsByLevelUsecase.call(level: level);

    result.fold(
      (failure) => emit(LevelPageWebFailure(failureMessage: failure.message)),
      (lessons) {
        for (var lesson in lessons) {
          log(lesson.lesson);
        }
        return emit(LevelPageWebLoaded(lessons: lessons));
      },
    );
  }
}
