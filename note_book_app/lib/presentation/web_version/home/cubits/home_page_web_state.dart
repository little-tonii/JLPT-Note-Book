import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

class HomePageWebState extends Equatable {
  final List<LevelEntity> levels;

  const HomePageWebState({required this.levels});

  HomePageWebState copyWith({List<LevelEntity>? levels}) {
    return HomePageWebState(levels: levels ?? this.levels);
  }

  @override
  List<Object?> get props => [levels];
}

class HomePageWebFailureState extends HomePageWebState {
  final String failureMessage;

  const HomePageWebFailureState(
      {required this.failureMessage, required super.levels});

  @override
  List<Object?> get props => [failureMessage, levels];
}

class HomePageWebLoadingState extends HomePageWebState {
  const HomePageWebLoadingState({required super.levels});

  @override
  List<Object?> get props => [levels];
}

class HomePageWebInitial extends HomePageWebState {
  HomePageWebInitial() : super(levels: []);

  @override
  List<Object?> get props => [levels];
}
