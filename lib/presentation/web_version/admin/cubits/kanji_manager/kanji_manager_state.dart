import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class KanjiManagerState extends Equatable {
  const KanjiManagerState();

  @override
  List<Object?> get props => [];
}

class KanjiManagerInitial extends KanjiManagerState {}

class KanjiManagerLoading extends KanjiManagerState {}

class KanjiManagerFailure extends KanjiManagerState {
  final String message;

  const KanjiManagerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class KanjiManagerLoaded extends KanjiManagerState {
  final String levelFilterState;
  final String lessonFilterState;
  final List<LevelEntity> levels;
  final List<LessonEntity> lessons;
  final List<KanjiEntity> kanjis;

  const KanjiManagerLoaded({
    required this.levelFilterState,
    required this.lessonFilterState,
    required this.levels,
    required this.lessons,
    required this.kanjis,
  });

  @override
  List<Object?> get props => [
        levels,
        lessons,
        levelFilterState,
        lessonFilterState,
        kanjis,
      ];
}
