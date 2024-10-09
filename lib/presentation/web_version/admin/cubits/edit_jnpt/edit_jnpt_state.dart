import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class EditJnptState extends Equatable {
  const EditJnptState();

  @override
  List<Object> get props => [];
}

class EditJnptInitial extends EditJnptState {}

class EditJnptLoading extends EditJnptState {}

class EditJnptLoaded extends EditJnptState {}

class EditJnptFailure extends EditJnptState {
  final String message;

  const EditJnptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditJnptSuccess extends EditJnptState {
  final String message;
  final LevelEntity level;

  const EditJnptSuccess({required this.message, required this.level});

  @override
  List<Object> get props => [message, level];
}
