import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';

abstract class CharacterPageWebState extends Equatable {
  const CharacterPageWebState();

  @override
  List<Object> get props => [];
}

class CharacterPageWebInitial extends CharacterPageWebState {
  const CharacterPageWebInitial();

  @override
  List<Object> get props => [];
}

class CharacterPageWebLoading extends CharacterPageWebState {
  const CharacterPageWebLoading();

  @override
  List<Object> get props => [];
}

class CharacterPageWebLoaded extends CharacterPageWebState {
  final List<CharacterEntity> characters;

  const CharacterPageWebLoaded({required this.characters});

  @override
  List<Object> get props => [characters];
}

class CharacterPageWebError extends CharacterPageWebState {
  final String message;

  const CharacterPageWebError({required this.message});

  @override
  List<Object> get props => [message];
}
