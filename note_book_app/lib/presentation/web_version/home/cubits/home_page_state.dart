import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {
  const HomePageInitial();

  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();

  @override
  List<Object> get props => [];
}

class GetAllLevelsSuccess extends HomePageState {
  final List<LevelEntity> levels;

  const GetAllLevelsSuccess({required this.levels});

  @override
  List<Object> get props => [levels];
}

class GetAllLevelsFailure extends HomePageState {
  final String message;

  const GetAllLevelsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
