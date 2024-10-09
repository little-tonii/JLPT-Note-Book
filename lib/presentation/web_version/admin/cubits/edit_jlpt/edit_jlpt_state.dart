import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class EditJlptState extends Equatable {
  const EditJlptState();

  @override
  List<Object> get props => [];
}

class EditJlptInitial extends EditJlptState {}

class EditJlptLoading extends EditJlptState {}

class EditJlptLoaded extends EditJlptState {}

class EditJlptFailure extends EditJlptState {
  final String message;

  const EditJlptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditJlptSuccess extends EditJlptState {
  final String message;
  final LevelEntity level;

  const EditJlptSuccess({required this.message, required this.level});

  @override
  List<Object> get props => [message, level];
}
