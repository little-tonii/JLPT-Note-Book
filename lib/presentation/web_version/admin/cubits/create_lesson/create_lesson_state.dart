import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class CreateLessonState extends Equatable {
  const CreateLessonState();

  @override
  List<Object> get props => [];
}

class CreateLessonInitial extends CreateLessonState {}

class CreateLessonLoading extends CreateLessonState {}

class CreateLessonLoaded extends CreateLessonState {
  final String levelId;

  const CreateLessonLoaded({required this.levelId});

  @override
  List<Object> get props => [levelId];
}

class CreateLessonFailure extends CreateLessonState {
  final String message;

  const CreateLessonFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateLessonSuccess extends CreateLessonState {
  final String message;
  final LessonEntity lesson;

  const CreateLessonSuccess({required this.message, required this.lesson});

  @override
  List<Object> get props => [message, lesson];
}
