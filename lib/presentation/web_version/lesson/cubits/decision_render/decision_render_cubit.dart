import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/lessons/get_lesson_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_state.dart';

class DecisionRenderCubit extends Cubit<DecisionRenderState> {
  final GetLessonByIdUsecase _getLessonByIdUsecase =
      getIt<GetLessonByIdUsecase>();
  final GetLevelByIdUsecase _getLevelByIdUsecase = getIt<GetLevelByIdUsecase>();

  DecisionRenderCubit() : super(DecisionRenderInitial());

  void makeDecision({required String lessonId}) async {
    final result = await _getLessonByIdUsecase.call(id: lessonId);
    result.fold((failure) {
      emit(DecisionRenderFailure(failureMessage: failure.message));
    }, (lesson) async {
      final level = await _getLevelByIdUsecase.call(id: lesson.levelId);
      level.fold((failure) {
        emit(DecisionRenderFailure(failureMessage: failure.message));
      }, (success) {
        if (lesson.lesson == 'Hiragana & Katakana') {
          emit(DecisionRenderCharacterPageWeb(lesson: lesson, level: success));
        } else if (lesson.lesson == 'Kanji') {
          emit(DecisionRenderKanjiPageWeb(lesson: lesson, level: success));
        } else {
          emit(DecisionRenderLessonPageWeb(lesson: lesson, level: success));
        }
      });
    });
  }
}
