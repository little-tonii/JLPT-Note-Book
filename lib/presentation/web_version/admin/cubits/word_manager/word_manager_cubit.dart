import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/domain/usecases/word/get_all_words_by_level_id_and_lesson_id_usecase.dart';
import 'package:note_book_app/domain/usecases/word/get_all_words_by_level_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_state.dart';

class WordManagerCubit extends Cubit<WordManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase =
      getIt.get<GetAllLevelsUsecase>();
  final GetAllLessonsByLevelIdUsecase _getAllLessonsByLevelIdUsecase =
      getIt.get<GetAllLessonsByLevelIdUsecase>();
  final GetAllWordsByLevelIdUsecase _getAllWordsByLevelIdUsecase =
      getIt.get<GetAllWordsByLevelIdUsecase>();
  final GetAllWordsByLevelIdAndLessonIdUsecase
      _getAllWordsByLevelIdAndLessonIdUsecase =
      getIt.get<GetAllWordsByLevelIdAndLessonIdUsecase>();

  WordManagerCubit() : super(WordManagerInitial());

  void init() async {
    emit(WordManagerLoaded(
      words: [],
      lessons: [],
      levels: [],
      selectedLevel: '',
      selectedLesson: '',
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
      final currentState = state as WordManagerLoaded;
      final lessonsResult =
          await _getAllLessonsByLevelIdUsecase.call(levelId: levelId);
      final wordsResult = await _getAllWordsByLevelIdUsecase.call(
        searchKey: '',
        levelId: levelId,
        pageNumber: 0,
        pageSize: 25,
      );
      List<LessonEntity> lessons = [];
      List<WordEntity> words = [];
      lessonsResult.fold(
        (failure) {
          emit(WordManagerFailure(message: failure.message));
        },
        (success) {
          lessons = success;
        },
      );
      wordsResult.fold(
        (failure) {
          emit(WordManagerFailure(message: failure.message));
        },
        (success) {
          words = success;
        },
      );
      emit(
        currentState.copyWith(
          selectedLevel: levelId,
          selectedLesson: 'null',
          lessons: lessons,
          words: words,
        ),
      );
    }
  }

  void updateLessonFilter({required String lessonId}) async {
    if (state is WordManagerLoaded) {
      final currentState = state as WordManagerLoaded;
      final wordsResult = await _getAllWordsByLevelIdAndLessonIdUsecase.call(
        searchKey: '',
        levelId: currentState.selectedLevel,
        lessonId: lessonId,
        pageNumber: 0,
        pageSize: 25,
      );
      wordsResult.fold(
        (failure) {
          emit(WordManagerFailure(message: failure.message));
        },
        (success) {
          emit(
            currentState.copyWith(
              selectedLesson: lessonId,
              words: success,
            ),
          );
        },
      );
    }
  }

  void loadMoreWords({required String searchKey}) async {
    if (state is WordManagerLoaded) {
      final currentState = state as WordManagerLoaded;
      final wordsResult = await _getAllWordsByLevelIdAndLessonIdUsecase.call(
        searchKey: searchKey,
        levelId: currentState.selectedLevel,
        lessonId: currentState.selectedLesson,
        pageNumber: currentState.pageNumber + 1,
        pageSize: currentState.pageSize,
      );
      wordsResult.fold(
        (failure) {
          emit(WordManagerFailure(message: failure.message));
        },
        (success) {
          if (success.isEmpty || success.length < currentState.pageSize) {
            emit(
              currentState.copyWith(
                hasReachedMax: true,
              ),
            );
          } else {
            emit(
              currentState.copyWith(
                words: currentState.words + success,
                pageNumber: currentState.pageNumber + 1,
              ),
            );
          }
        },
      );
    }
  }
}
