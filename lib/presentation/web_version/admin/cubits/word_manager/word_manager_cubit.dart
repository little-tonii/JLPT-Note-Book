import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_state.dart';

class WordManagerCubit extends Cubit<WordManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase =
      getIt.get<GetAllLevelsUsecase>();
  final GetAllLessonsByLevelIdUsecase _getAllLessonsByLevelIdUsecase =
      getIt.get<GetAllLessonsByLevelIdUsecase>();

  WordManagerCubit() : super(WordManagerInitial());

  void init() async {
    emit(WordManagerLoaded(
      words: [],
      lessons: [],
      levels: [],
      selectedLevel: 'null',
      selectedLesson: 'null',
      hasReachedMax: false,
      pageNumber: 0,
      pageSize: 25,
    ));
    final levels = await _getAllLevelsUsecase.call();
    levels.fold((failure) {
      emit(WordManagerFailure(message: failure.message));
    }, (success) {
      emit((state as WordManagerLoaded).copyWith(levels: success));
    });
  }

  void updateLevelFilter({required String levelId}) async {
    if (state is WordManagerLoaded) {
      
    }
  }

  void updateLessonFilter({required String lessonId}) async {
    if (state is WordManagerLoaded) {
      
    }
  }

  
}
