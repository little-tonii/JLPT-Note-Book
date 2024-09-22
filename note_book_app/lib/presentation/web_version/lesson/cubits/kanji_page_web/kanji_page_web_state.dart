import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';

abstract class KanjiPageWebState extends Equatable {
  const KanjiPageWebState();

  @override
  List<Object?> get props => [];
}

class KanjiPageWebInitial extends KanjiPageWebState {}

class KanjiPageWebLoading extends KanjiPageWebState {}

class KanjiPageWebLoaded extends KanjiPageWebState {
  final List<KanjiEntity> kanjis;

  const KanjiPageWebLoaded({required this.kanjis});

  @override
  List<Object?> get props => [kanjis];
}

class KanjiPageWebFailure extends KanjiPageWebState {
  final String failureMessage;

  const KanjiPageWebFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
