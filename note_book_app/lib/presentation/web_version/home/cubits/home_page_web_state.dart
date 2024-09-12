import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class HomePageWebState extends Equatable {
  const HomePageWebState();

  @override
  List<Object> get props => [];
}

class HomePageWebInitial extends HomePageWebState {
  const HomePageWebInitial();

  @override
  List<Object> get props => [];
}

class HomePageWebLoading extends HomePageWebState {
  const HomePageWebLoading();

  @override
  List<Object> get props => [];
}

class GetAllLevelsSuccess extends HomePageWebState {
  final List<LevelEntity> levels;

  const GetAllLevelsSuccess({required this.levels});

  @override
  List<Object> get props => [levels];
}

class GetAllLevelsFailure extends HomePageWebState {
  final String message;

  const GetAllLevelsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
