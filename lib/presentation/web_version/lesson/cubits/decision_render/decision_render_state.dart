import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class DecisionRenderState extends Equatable {
  const DecisionRenderState();

  @override
  List<Object?> get props => [];
}

class DecisionRenderInitial extends DecisionRenderState {}

class DecisionRenderCharacterPageWeb extends DecisionRenderState {
  final LessonEntity lesson;
  final LevelEntity level;

  const DecisionRenderCharacterPageWeb({required this.lesson, required this.level});

  @override
  List<Object?> get props => [lesson, level];
}

class DecisionRenderLessonPageWeb extends DecisionRenderState {
  final LevelEntity level;
  final LessonEntity lesson;

  const DecisionRenderLessonPageWeb({required this.lesson, required this.level});

  @override
  List<Object?> get props => [lesson, level];
}

class DecisionRenderKanjiPageWeb extends DecisionRenderState {
  final LessonEntity lesson;
  final LevelEntity level;

  const DecisionRenderKanjiPageWeb({required this.lesson, required this.level});

  @override
  List<Object?> get props => [lesson, level];
}

class DecisionRenderFailure extends DecisionRenderState {
  final String failureMessage;
  const DecisionRenderFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
