import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class LessonManagerState extends Equatable {
  const LessonManagerState();

  @override
  List<Object> get props => [];
}

class LessonManagerInitial extends LessonManagerState {}

class LessonManagerLoading extends LessonManagerState {}

class LessonManagerLoaded extends LessonManagerState {
  final List<LessonEntity> lessons;
  final List<LevelEntity> levels;
  final String selectedLevelId;

  const LessonManagerLoaded({
    required this.lessons,
    required this.levels,
    required this.selectedLevelId,
  });

  @override
  List<Object> get props => [lessons, levels, selectedLevelId];

  LessonManagerLoaded copyWith({
    List<LessonEntity>? lessons,
    List<LevelEntity>? levels,
    String? selectedLevelId,
  }) {
    return LessonManagerLoaded(
      lessons: lessons ?? this.lessons,
      levels: levels ?? this.levels,
      selectedLevelId: selectedLevelId ?? this.selectedLevelId,
    );
  }
}

class LessonManagerFailure extends LessonManagerState {
  final String message;

  const LessonManagerFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class LessonManagerSuccess extends LessonManagerState {
  final String message;

  const LessonManagerSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
