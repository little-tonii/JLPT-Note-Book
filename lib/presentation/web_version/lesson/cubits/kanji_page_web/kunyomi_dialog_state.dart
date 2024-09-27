import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';

abstract class KunyomiDialogState extends Equatable {
  const KunyomiDialogState();

  @override
  List<Object?> get props => [];
}

class KunyomiDialogInitial extends KunyomiDialogState {}

class KunyomiDialogLoading extends KunyomiDialogState {}

class KunyomiDialogLoaded extends KunyomiDialogState {
  final List<KunyomiEntity> kunyomis;

  const KunyomiDialogLoaded({required this.kunyomis});

  @override
  List<Object?> get props => [kunyomis];
}

class KunyomiDialogFailure extends KunyomiDialogState {
  final String failureMessage;

  const KunyomiDialogFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}