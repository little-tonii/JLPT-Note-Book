import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class HomePageWebState extends Equatable {
  const HomePageWebState();

  @override
  List<Object?> get props => [];
}

class HomePageWebInitial extends HomePageWebState {}

class HomePageWebLoading extends HomePageWebState {}

class HomePageWebLoaded extends HomePageWebState {
  final List<LevelEntity> levels;

  const HomePageWebLoaded({required this.levels});

  @override
  List<Object?> get props => [levels];
}

class HomePageWebFailure extends HomePageWebState {
  final String failureMessage;

  const HomePageWebFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
