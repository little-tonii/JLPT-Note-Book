import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class DecisionRenderState extends Equatable {
  const DecisionRenderState();

  @override
  List<Object?> get props => [];
}

class DecisionRenderInitial extends DecisionRenderState {}

class DecisionRenderCharacterPageWeb extends DecisionRenderState {
  final LessonEntity lesson;

  const DecisionRenderCharacterPageWeb({required this.lesson});

  @override
  List<Object?> get props => [lesson];
}

class DecisionRenderLessonPageWeb extends DecisionRenderState {
  final LessonEntity lesson;
  const DecisionRenderLessonPageWeb({required this.lesson});

  @override
  List<Object?> get props => [lesson];
}

class DecisionRenderKanjiPageWeb extends DecisionRenderState {
  final LessonEntity lesson;
  const DecisionRenderKanjiPageWeb({required this.lesson});

  @override
  List<Object?> get props => [lesson];
}

class DecisionRenderFailure extends DecisionRenderState {
  final String failureMessage;
  const DecisionRenderFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
