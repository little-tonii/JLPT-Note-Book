import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/domain/usecases/word/create_word_by_level_id_and_lesson_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/import_word_data/import_word_data_state.dart';

class ImportWordDataCubit extends Cubit<ImportWordDataState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase =
      getIt.get<GetAllLevelsUsecase>();
  final GetAllLessonsByLevelIdUsecase _getAllLessonsByLevelIdUsecase =
      getIt.get<GetAllLessonsByLevelIdUsecase>();
  final CreateWordByLevelIdAndLessonIdUsecase
      _createWordByLevelIdAndLessonIdUsecase =
      getIt.get<CreateWordByLevelIdAndLessonIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt.get<CreateAdminLogUsecase>();

  ImportWordDataCubit() : super(ImportWordDataInitial());

  void init() async {
    final levels = await _getAllLevelsUsecase.call();
    levels.fold(
      (failure) {
        emit(ImportWordDataFailure(message: failure.message));
      },
      (success) {
        emit(ImportWordDataLoaded(
          words: [],
          levels: success,
          lessons: [],
          selectedLevel: '',
          selectedLesson: '',
          fileSelected: false,
        ));
      },
    );
  }

  void updateLevelFilter({required String levelId}) async {
    if (state is ImportWordDataLoaded) {
      final currentState = state as ImportWordDataLoaded;
      final lessonsResult =
          await _getAllLessonsByLevelIdUsecase.call(levelId: levelId);
      lessonsResult.fold(
        (failure) {
          emit(ImportWordDataFailure(message: failure.message));
        },
        (success) {
          emit(currentState.copyWith(
            fileSelected: false,
            words: [],
            lessons: success,
            selectedLevel: levelId,
            selectedLesson: '',
          ));
        },
      );
    }
  }

  void updateLessonFilter({required String lessonId}) {
    if (state is ImportWordDataLoaded) {
      final currentState = state as ImportWordDataLoaded;
      emit(currentState.copyWith(
        selectedLesson: lessonId,
        fileSelected: false,
        words: [],
      ));
    }
  }

  void handleJsonData({required List<dynamic> jsonData}) {
    if (state is ImportWordDataLoaded) {
      final currentState = state as ImportWordDataLoaded;
      emit(ImportWordDataLoading());
      final now = Timestamp.now();
      final words = jsonData
          .map(
            (word) => WordEntity(
              id: '',
              word: word["word"],
              meaning: word["meaning"],
              kanjiForm: word["kanjiForm"],
              lessonId: currentState.selectedLesson,
              levelId: currentState.selectedLevel,
              createdAt: now,
            ),
          )
          .toList();

      emit(currentState.copyWith(words: words, fileSelected: true));
    }
  }

  void saveData() async {
    if (state is ImportWordDataLoaded) {
      final currentState = state as ImportWordDataLoaded;
      emit(ImportWordSaveDataLoading());
      int numWordsCreated = 0;
      int numWordsFailed = 0;
      for (final word in currentState.words) {
        final createdWord = await _createWordByLevelIdAndLessonIdUsecase.call(
          levelId: currentState.selectedLevel,
          lessonId: currentState.selectedLesson,
          word: word.word,
          meaning: word.meaning,
          kanjiForm: word.kanjiForm,
        );
        createdWord.fold(
          (failure) {
            numWordsFailed++;
          },
          (success) {
            numWordsCreated++;
          },
        );
      }
      if (numWordsCreated == currentState.words.length) {
        final message = 'Nhập dữ liệu từ vựng thành công';
        await _createAdminLogUsecase.call(
          message:
              '$message. JLPT: ${currentState.selectedLevel}. Bài học: ${currentState.selectedLesson}. Số từ vựng tạo thành công: $numWordsCreated, Số từ vựng tạo thất bại: $numWordsFailed.',
          action: "CREATE",
          actionStatus: "SUCCESS",
        );
        emit(ImportWordDataSuccess(message: message));
      } else {
        final message = 'Có lỗi xảy ra trong quá trình nhập dữ liệu từ vựng';
        await _createAdminLogUsecase.call(
          message:
              '$message. JLPT: ${currentState.selectedLevel}. Bài học: ${currentState.selectedLesson}. Số từ vựng tạo thành công: $numWordsCreated, Số từ vựng tạo thất bại: $numWordsFailed.',
          action: "CREATE",
          actionStatus: "FAILED",
        );
        emit(ImportWordDataFailure(message: message));
      }
    }
  }
}
