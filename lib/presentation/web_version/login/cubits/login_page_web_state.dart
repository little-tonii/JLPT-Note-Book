import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/user_entity.dart';

abstract class LoginPageWebState extends Equatable {
  const LoginPageWebState();

  @override
  List<Object> get props => [];
}

class LoginPageWebInitial extends LoginPageWebState {}

class LoginPageWebLoading extends LoginPageWebState {}

class LoginPageWebSuccess extends LoginPageWebState {
  final UserEntity user;

  const LoginPageWebSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginPageWebFailure extends LoginPageWebState {
  final String message;

  const LoginPageWebFailure({required this.message});

  @override
  List<Object> get props => [message];
}
