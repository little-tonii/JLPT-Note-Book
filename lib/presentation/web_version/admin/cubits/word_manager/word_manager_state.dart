import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';

abstract class WordManagerState extends Equatable {
  const WordManagerState();

  @override
  List<Object?> get props => [];
}

class WordManagerInitial extends WordManagerState {}

class WordManagerLoaded extends WordManagerState {
  final List<LessonEntity> lessons;
  final List<LevelEntity> levels;
  final List<WordEntity> words;
  final String selectedLevel;
  final String selectedLesson;
  final bool hasReachedMax;
  final int pageNumber;
  final int pageSize;

  const WordManagerLoaded({
    required this.lessons,
    required this.levels,
    required this.selectedLevel,
    required this.selectedLesson,
    required this.hasReachedMax,
    required this.words,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  List<Object?> get props =>
      [lessons, levels, selectedLevel, selectedLesson, hasReachedMax, words, pageNumber, pageSize];

  WordManagerLoaded copyWith({
    List<LessonEntity>? lessons,
    List<LevelEntity>? levels,
    String? selectedLevel,
    String? selectedLesson,
    bool? hasReachedMax,
    List<WordEntity>? words,
    int? pageNumber,
    int? pageSize,
  }) {
    return WordManagerLoaded(
      words: words ?? this.words,
      lessons: lessons ?? this.lessons,
      levels: levels ?? this.levels,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedLesson: selectedLesson ?? this.selectedLesson,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class WordManagerFailure extends WordManagerState {
  final String message;

  const WordManagerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
