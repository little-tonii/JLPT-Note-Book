import 'package:equatable/equatable.dart';

abstract class CreateLessonState extends Equatable {
  const CreateLessonState();

  @override
  List<Object> get props => [];
}

class CreateLessonInitial extends CreateLessonState {}

class CreateLessonLoading extends CreateLessonState {}

