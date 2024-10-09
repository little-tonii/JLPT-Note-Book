import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class DeleteJlptState extends Equatable {
  const DeleteJlptState();

  @override
  List<Object> get props => [];
}

class DeleteJlptInitial extends DeleteJlptState {}

class DeleteJlptLoading extends DeleteJlptState {}

class DeleteJlptLoaded extends DeleteJlptState {}

class DeleteJlptFailure extends DeleteJlptState {
  final String message;

  const DeleteJlptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteJlptSuccess extends DeleteJlptState {
  final String message;
  final LevelEntity levelEntity;

  const DeleteJlptSuccess({required this.message, required this.levelEntity});

  @override
  List<Object> get props => [message, levelEntity];
}
