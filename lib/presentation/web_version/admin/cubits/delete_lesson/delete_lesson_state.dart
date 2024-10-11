import 'package:equatable/equatable.dart';

abstract class DeleteLessonState extends Equatable {
  const DeleteLessonState();

  @override
  List<Object> get props => [];
}

class DeleteLessonInitial extends DeleteLessonState {}

class DeleteLessonLoading extends DeleteLessonState {}

class DeleteLessonLoaded extends DeleteLessonState {}

class DeleteLessonSuccess extends DeleteLessonState {
  final String message;
  final String lessonId;

  const DeleteLessonSuccess({required this.message, required this.lessonId});

  @override
  List<Object> get props => [message, lessonId];
}

class DeleteLessonFailure extends DeleteLessonState {
  final String message;

  const DeleteLessonFailure({required this.message});

  @override
  List<Object> get props => [message];
}
