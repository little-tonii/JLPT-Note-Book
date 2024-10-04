import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';

class KanjiManagerCubit extends Cubit<KanjiManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();
  final GetAllLessonsByLevelUsecase _getAllLessonsByLevelUsecase =
      getIt<GetAllLessonsByLevelUsecase>();
  final GetAllKanjisByLevelUsecase _getAllKanjisByLevelUsecase =
      getIt<GetAllKanjisByLevelUsecase>();

  KanjiManagerCubit() : super(KanjiManagerInitial());

  void updateFilterChoice({String? level, String? lesson}) async {
    if (state is KanjiManagerInitial) {
      final levels = await _getAllLevelsUsecase.call();
      levels.fold(
        (failure) => emit(KanjiManagerFailure(message: failure.message)),
        (result) => emit(KanjiManagerLoaded(
          kanjis: const [],
          levels: result,
          lessons: const [],
          levelFilterState: '',
          lessonFilterState: '',
        )),
      );
    }
    if (state is KanjiManagerLoaded) {
      String levelFilter = level ?? '';
      String lessonFilter = lesson ?? '';
      if (levelFilter.isNotEmpty) {
        final lessons =
            await _getAllLessonsByLevelUsecase.call(level: levelFilter);
        lessons.fold(
          (failure) => emit(KanjiManagerFailure(message: failure.message)),
          (result) {
            final currentState = state as KanjiManagerLoaded;
            emit(KanjiManagerLoaded(
              kanjis: currentState.kanjis,
              levels: currentState.levels,
              lessons: result,
              levelFilterState: levelFilter,
              lessonFilterState: lessonFilter,
            ));
          },
        );
      }
      if (lessonFilter.isNotEmpty) {
        final currentState = state as KanjiManagerLoaded;
        emit(KanjiManagerLoaded(
          kanjis: currentState.kanjis,
          levels: currentState.levels,
          lessons: currentState.lessons,
          levelFilterState: levelFilter,
          lessonFilterState: lessonFilter,
        ));
      }
    }
  }

  void searchKanjis({
    required String hanVietSearchKey,
    bool refresh = false,
  }) async {
    
  }
}
