import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
import 'package:note_book_app/domain/usecases/create_character_question_usecase.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_state.dart';

class CharacterQuestionPhaseWebCubit
    extends Cubit<CharacterQuestionPhaseWebState> {
  final CreateCharacterQuestionUsecase _createCharacterQuestionUsecase =
      getIt<CreateCharacterQuestionUsecase>();

  List<QuestionEntity> questions = [];

  CharacterQuestionPhaseWebCubit()
      : super(const CharacterQuestionPhaseWebInitial());

  void startPhase({
    required int numberOfQuestions,
    required String questionType,
    required String answerType,
  }) async {
    emit(const CharacterQuestionPhaseWebLoading());
    final result = await _createCharacterQuestionUsecase.call(
      numberOfQuestions: numberOfQuestions,
      questionType: questionType,
      answerType: answerType,
    );
    result.fold(
      (failure) =>
          emit(CharacterQuestionPhaseWebError(message: failure.message)),
      (questions) {
        this.questions = questions;
        emit(CharacterQuestionPhaseWebLoaded(question: questions.first));
      },
    );
    for (var element in questions) {
      log(element.question);
    }
  }

  void nextQuestion() {}

  void answerQuestion() {}

  void endPhase() {}
}
