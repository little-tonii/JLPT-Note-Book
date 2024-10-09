import 'package:equatable/equatable.dart';

abstract class CreateNewJnptState extends Equatable {
  const CreateNewJnptState();

  @override
  List<Object> get props => [];
}

class CreateNewJnptInitial extends CreateNewJnptState {}

class CreateNewJnptLoading extends CreateNewJnptState {}

class CreateNewJnptLoaded extends CreateNewJnptState {}

class CreateNewJnptFailure extends CreateNewJnptState {
  final String message;

  const CreateNewJnptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateNewJnptSuccess extends CreateNewJnptState {
  final String message;

  const CreateNewJnptSuccess({required this.message});

  @override
  List<Object> get props => [message];
}