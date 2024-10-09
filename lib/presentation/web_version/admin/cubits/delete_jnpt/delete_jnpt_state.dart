import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class DeleteJnptState extends Equatable {
  const DeleteJnptState();

  @override
  List<Object> get props => [];
}

class DeleteJnptInitial extends DeleteJnptState {}

class DeleteJnptLoading extends DeleteJnptState {}

class DeleteJnptLoaded extends DeleteJnptState {}

class DeleteJnptFailure extends DeleteJnptState {
  final String message;

  const DeleteJnptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteJnptSuccess extends DeleteJnptState {
  final String message;
  final LevelEntity levelEntity;

  const DeleteJnptSuccess({required this.message, required this.levelEntity});

  @override
  List<Object> get props => [message, levelEntity];
}
