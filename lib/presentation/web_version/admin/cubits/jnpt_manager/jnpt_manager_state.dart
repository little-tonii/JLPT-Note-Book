import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class JnptManagerState extends Equatable {
  const JnptManagerState();

  @override
  List<Object> get props => [];
}

class JnptManagerInitial extends JnptManagerState {}

class JnptManagerLoading extends JnptManagerState {}

class JnptManagerLoaded extends JnptManagerState {
  final String searchValue;
  final List<LevelEntity> levels;

  const JnptManagerLoaded({required this.levels, required this.searchValue});

  @override
  List<Object> get props => [levels, searchValue];

  JnptManagerLoaded copyWith({
    List<LevelEntity>? levels,
    String? searchValue,
  }) {
    return JnptManagerLoaded(
      levels: levels ?? this.levels,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}

class JnptManagerFailure extends JnptManagerState {
  final String message;

  const JnptManagerFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class JnptManagerSuccess extends JnptManagerState {
  final String message;

  const JnptManagerSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
