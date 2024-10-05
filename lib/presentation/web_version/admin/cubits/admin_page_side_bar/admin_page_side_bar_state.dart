import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/user_entity.dart';

abstract class AdminPageSideBarState extends Equatable {
  const AdminPageSideBarState();

  @override
  List<Object> get props => [];
}

class AdminPageSideBarInitial extends AdminPageSideBarState {}

class AdminPageSideBarLoading extends AdminPageSideBarState {}

class AdminPageSideBarLoaded extends AdminPageSideBarState {
  final int selectedIndex;
  final UserEntity user;

  const AdminPageSideBarLoaded({
    required this.selectedIndex,
    required this.user,
  });

  @override
  List<Object> get props => [selectedIndex, user];
}

class AdminPageSideBarFailure extends AdminPageSideBarState {
  final String message;

  const AdminPageSideBarFailure({required this.message});

  @override
  List<Object> get props => [message];
}
