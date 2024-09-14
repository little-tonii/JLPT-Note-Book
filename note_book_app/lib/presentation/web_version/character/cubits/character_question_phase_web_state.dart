import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';

abstract class CharacterQuestionPhaseWebState extends Equatable {
  const CharacterQuestionPhaseWebState();

  @override
  List<Object> get props => [];
}

class CharacterQuestionPhaseWebInitial extends CharacterQuestionPhaseWebState {
  const CharacterQuestionPhaseWebInitial();

  @override
  List<Object> get props => [];
}

class CharacterQuestionPhaseWebLoading extends CharacterQuestionPhaseWebState {
  const CharacterQuestionPhaseWebLoading();

  @override
  List<Object> get props => [];
}

class CharacterQuestionPhaseWebError extends CharacterQuestionPhaseWebState {
  final String message;

  const CharacterQuestionPhaseWebError({required this.message});

  @override
  List<Object> get props => [message];
}

class CharacterQuestionPhaseWebLoaded extends CharacterQuestionPhaseWebState {
  final QuestionEntity question;

  const CharacterQuestionPhaseWebLoaded({required this.question});

  @override
  List<Object> get props => [question];
}

class CharacterQuestionPhaseWebCorrectAnswer
    extends CharacterQuestionPhaseWebState {
  final String correctAnswer;

  const CharacterQuestionPhaseWebCorrectAnswer({required this.correctAnswer});

  @override
  List<Object> get props => [correctAnswer];
}

class CharacterQuestionPhaseWebWrongAnswer
    extends CharacterQuestionPhaseWebState {
  final String correctAnswer;
  const CharacterQuestionPhaseWebWrongAnswer({required this.correctAnswer});

  @override
  List<Object> get props => [correctAnswer];
}

class CharacterQuestionPhaseWebEnd extends CharacterQuestionPhaseWebState {
  const CharacterQuestionPhaseWebEnd();

  @override
  List<Object> get props => [];
}
