import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class CreateNewJlptState extends Equatable {
  const CreateNewJlptState();

  @override
  List<Object> get props => [];
}

class CreateNewJlptInitial extends CreateNewJlptState {}

class CreateNewJlptLoading extends CreateNewJlptState {}

class CreateNewJlptLoaded extends CreateNewJlptState {}

class CreateNewJlptFailure extends CreateNewJlptState {
  final String message;

  const CreateNewJlptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateNewJlptSuccess extends CreateNewJlptState {
  final String message;
  final LevelEntity levelEntity;

  const CreateNewJlptSuccess(
      {required this.message, required this.levelEntity});

  @override
  List<Object> get props => [message, levelEntity];
}
