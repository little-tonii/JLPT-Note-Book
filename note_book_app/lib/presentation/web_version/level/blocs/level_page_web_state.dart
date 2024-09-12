import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_details_entity.dart';

abstract class LevelPageWebState extends Equatable {
  const LevelPageWebState();

  @override
  List<Object> get props => [];
}

class LevelPageWebInitial extends LevelPageWebState {
  const LevelPageWebInitial();

  @override
  List<Object> get props => [];
}

class LevelPageWebLoading extends LevelPageWebState {
  const LevelPageWebLoading();

  @override
  List<Object> get props => [];
}

class LevelPageWebLoaded extends LevelPageWebState {
  final List<LevelDetailsEntity> levelDetails;

  const LevelPageWebLoaded({required this.levelDetails});

  @override
  List<Object> get props => [levelDetails];
}

class LevelPageWebError extends LevelPageWebState {
  final String message;

  const LevelPageWebError({required this.message});

  @override
  List<Object> get props => [message];
}
