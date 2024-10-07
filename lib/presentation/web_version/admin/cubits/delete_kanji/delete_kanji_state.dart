import 'package:equatable/equatable.dart';

abstract class DeleteKanjiState extends Equatable {
  const DeleteKanjiState();

  @override
  List<Object> get props => [];
}

class DeleteKanjiInitial extends DeleteKanjiState {}

class DeleteKanjiLoading extends DeleteKanjiState {}

class DeleteKanjiSuccess extends DeleteKanjiState {
  final String message;
  final String id;

  const DeleteKanjiSuccess({required this.message, required this.id});

  @override
  List<Object> get props => [message, id];
}

class DeleteKanjiFailure extends DeleteKanjiState {
  final String message;

  const DeleteKanjiFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteKanjiLoaded extends DeleteKanjiState {
  final String id;
  final String kanji;
  final String kun;
  final String on;
  final String viet;

  const DeleteKanjiLoaded({
    required this.id,
    required this.kanji,
    required this.kun,
    required this.on,
    required this.viet,
  });

  @override
  List<Object> get props => [id, kanji, kun, on, viet];
}
