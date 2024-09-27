import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class LevelPageWebState extends Equatable {
  const LevelPageWebState();

  @override
  List<Object?> get props => [];
}

class LevelPageWebInitial extends LevelPageWebState {}

class LevelPageWebLoading extends LevelPageWebState {}

class LevelPageWebLoaded extends LevelPageWebState {
  final List<LessonEntity> lessons;

  const LevelPageWebLoaded({required this.lessons});

  @override
  List<Object?> get props => [lessons];
}

class LevelPageWebFailure extends LevelPageWebState {
  final String failureMessage;

  const LevelPageWebFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class LevelPageWebTitle extends LevelPageWebState {
  final String title;

  const LevelPageWebTitle({required this.title});

  @override
  List<Object?> get props => [title];
}
