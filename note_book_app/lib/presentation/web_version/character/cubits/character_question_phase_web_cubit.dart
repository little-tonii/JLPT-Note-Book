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
  String currentAnswer = '';

  CharacterQuestionPhaseWebCubit()
      : super(const CharacterQuestionPhaseWebInitial());

  void startPhase({
    required int numberOfQuestions,
    required String questionType,
    required String answerType,
  }) async {
    questions = [];
    correctAnswers = 0;
    currentQuestion = 0;
    currentAnswer = '';
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
      if (currentQuestion == questions.length) {
        endPhase();
        return;
      }
      currentQuestion++;
      currentAnswer = '';
      emit(
        CharacterQuestionPhaseWebLoaded(
          question: questions[currentQuestion - 1],
        ),
      );
    }
  }

  void answerQuestion({required String answer}) {
    if (currentAnswer.isNotEmpty) return;
    currentAnswer = answer;
    if (questions[currentQuestion - 1].correctAnswer == answer) {
      correctAnswers++;
      emit(CharacterQuestionPhaseWebCorrectAnswer(
          correctAnswer: questions[currentQuestion - 1].correctAnswer));
    } else {
      emit(
        CharacterQuestionPhaseWebWrongAnswer(
            correctAnswer: questions[currentQuestion - 1].correctAnswer),
      );
    }
  }

  void endPhase() {
    emit(const CharacterQuestionPhaseWebEnd());
  }
}
