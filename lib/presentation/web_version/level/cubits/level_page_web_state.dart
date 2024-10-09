import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class LevelPageWebState extends Equatable {
  const LevelPageWebState();

  @override
  List<Object?> get props => [];
}

class LevelPageWebInitial extends LevelPageWebState {}

class LevelPageWebLoading extends LevelPageWebState {}

class LevelPageWebLoaded extends LevelPageWebState {
  final List<LessonEntity> lessons;
  final LevelEntity level;

  const LevelPageWebLoaded({required this.lessons, required this.level});

  @override
  List<Object?> get props => [lessons, level];
}

class LevelPageWebFailure extends LevelPageWebState {
  final String failureMessage;

  const LevelPageWebFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class LevelPageWebTitle extends LevelPageWebState {
  final LevelEntity level;

  const LevelPageWebTitle({required this.level});

  @override
  List<Object?> get props => [level];
}
