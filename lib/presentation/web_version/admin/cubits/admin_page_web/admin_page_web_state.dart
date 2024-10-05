import 'package:equatable/equatable.dart';

abstract class AdminPageWebState extends Equatable {
  const AdminPageWebState();

  @override
  List<Object> get props => [];
}

class AdminPageWebInitial extends AdminPageWebState {}

class AdminPageWebLoading extends AdminPageWebState {}

class AdminPageWebUserNotLoggedIn extends AdminPageWebState {}

class AdminPageWebFailure extends AdminPageWebState {
  final String message;

  const AdminPageWebFailure({required this.message});

  @override
  List<Object> get props => [message];
}
