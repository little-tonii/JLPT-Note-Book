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
  int correctAnswers = 0;
  int currentQuestion = 0;
  bool isCurrentQuestionAnswered = false;

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
    currentQuestion++;
    result.fold(
      (failure) =>
          emit(CharacterQuestionPhaseWebError(message: failure.message)),
      (questions) {
        this.questions = questions;
        emit(CharacterQuestionPhaseWebLoaded(question: questions.first));
      },
    );
  }

  void nextQuestion() {
    if (currentQuestion <= questions.length) {
      currentQuestion++;
      isCurrentQuestionAnswered = false;
      emit(
        CharacterQuestionPhaseWebLoaded(
          question: questions[currentQuestion - 1],
        ),
      );
    } else {
      endPhase();
    }
  }

  void answerQuestion({required String answer}) {
    if (isCurrentQuestionAnswered) return;
    if (questions[currentQuestion - 1].correctAnswer == answer) {
      correctAnswers++;
      emit(const CharacterQuestionPhaseWebCorrectAnswer());
    } else {
      emit(const CharacterQuestionPhaseWebWrongAnswer());
    }
  }

  void endPhase() {
    emit(const CharacterQuestionPhaseWebEnd());
  }
}
