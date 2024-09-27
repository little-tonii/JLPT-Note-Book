import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';

abstract class OnyomiDialogState extends Equatable {
  const OnyomiDialogState();

  @override
  List<Object?> get props => [];
}

class OnyomiDialogInitial extends OnyomiDialogState {}

class OnyomiDialogLoading extends OnyomiDialogState {}

class OnyomiDialogLoaded extends OnyomiDialogState {
  final List<OnyomiEntity> onyomis;

  const OnyomiDialogLoaded({required this.onyomis});

  @override
  List<Object?> get props => [onyomis];
}

class OnyomiDialogFailure extends OnyomiDialogState {
  final String failureMessage;

  const OnyomiDialogFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
