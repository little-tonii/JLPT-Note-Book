import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class JlptManagerState extends Equatable {
  const JlptManagerState();

  @override
  List<Object> get props => [];
}

class JlptManagerInitial extends JlptManagerState {}

class JlptManagerLoading extends JlptManagerState {}

class JlptManagerLoaded extends JlptManagerState {
  final String searchValue;
  final List<LevelEntity> levels;

  const JlptManagerLoaded({required this.levels, required this.searchValue});

  @override
  List<Object> get props => [levels, searchValue];

  JlptManagerLoaded copyWith({
    List<LevelEntity>? levels,
    String? searchValue,
  }) {
    return JlptManagerLoaded(
      levels: levels ?? this.levels,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}

class JlptManagerFailure extends JlptManagerState {
  final String message;

  const JlptManagerFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class JlptManagerSuccess extends JlptManagerState {
  final String message;

  const JlptManagerSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
