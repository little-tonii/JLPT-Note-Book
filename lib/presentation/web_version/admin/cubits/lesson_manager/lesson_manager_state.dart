import 'package:equatable/equatable.dart';

abstract class LessonManagerState extends Equatable {
  const LessonManagerState();

  @override
  List<Object> get props => [];
}

class LessonManagerInitial extends LessonManagerState {}

class LessonManagerLoading extends LessonManagerState {}

class LessonManagerLoaded extends LessonManagerState {}

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
