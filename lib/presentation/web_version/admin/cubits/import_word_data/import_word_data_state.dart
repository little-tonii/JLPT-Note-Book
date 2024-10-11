import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';

abstract class ImportWordDataState extends Equatable {
  const ImportWordDataState();

  @override
  List<Object> get props => [];
}

class ImportWordDataInitial extends ImportWordDataState {}

class ImportWordDataLoading extends ImportWordDataState {}

class ImportWordSaveDataLoading extends ImportWordDataState {}

class ImportWordDataSuccess extends ImportWordDataState {
  final String message;

  const ImportWordDataSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ImportWordDataFailure extends ImportWordDataState {
  final String message;

  const ImportWordDataFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ImportWordDataLoaded extends ImportWordDataState {
  final List<LevelEntity> levels;
  final List<LessonEntity> lessons;
  final String selectedLevel;
  final String selectedLesson;
  final bool fileSelected;
  final List<WordEntity> words;

  const ImportWordDataLoaded({
    required this.levels,
    required this.lessons,
    required this.selectedLevel,
    required this.selectedLesson,
    required this.fileSelected,
    required this.words,
  });

  @override
  List<Object> get props =>
      [fileSelected, levels, lessons, selectedLevel, selectedLesson];

  ImportWordDataLoaded copyWith({
    List<LevelEntity>? levels,
    List<LessonEntity>? lessons,
    List<WordEntity>? words,
    String? selectedLevel,
    String? selectedLesson,
    bool? fileSelected,
  }) {
    return ImportWordDataLoaded(
      levels: levels ?? this.levels,
      lessons: lessons ?? this.lessons,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedLesson: selectedLesson ?? this.selectedLesson,
      fileSelected: fileSelected ?? this.fileSelected,
      words: words ?? this.words,
    );
  }
}
