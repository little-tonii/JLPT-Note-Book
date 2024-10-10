import 'package:equatable/equatable.dart';

abstract class EditLessonState extends Equatable {
  const EditLessonState();

  @override
  List<Object> get props => [];
}

class EditLessonInitial extends EditLessonState {}

class EditLessonLoading extends EditLessonState {}