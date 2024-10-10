import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

abstract class EditLessonState extends Equatable {
  const EditLessonState();

  @override
  List<Object> get props => [];
}

class EditLessonInitial extends EditLessonState {}

class EditLessonLoading extends EditLessonState {}

class EditLessonFailure extends EditLessonState {
  final String message;

  const EditLessonFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditLessonSuccess extends EditLessonState {
  final String message;
  final LessonEntity lesson;

  const EditLessonSuccess({required this.message, required this.lesson});

  @override
  List<Object> get props => [message, lesson];
}