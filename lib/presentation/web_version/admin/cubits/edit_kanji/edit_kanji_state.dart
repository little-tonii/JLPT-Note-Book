import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';

abstract class EditKanjiState extends Equatable {
  const EditKanjiState();

  @override
  List<Object> get props => [];
}

class EditKanjiInitial extends EditKanjiState {}

class EditKanjiSuccess extends EditKanjiState {
  final String message;

  const EditKanjiSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class EditKanjiFailure extends EditKanjiState {
  final String message;

  const EditKanjiFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class EditKanjiLoaded extends EditKanjiState {
  final KanjiEntity kanji;
  final List<KunyomiEntity> kunyomis;
  final List<OnyomiEntity> onyomis;

  const EditKanjiLoaded({
    required this.kanji,
    required this.kunyomis,
    required this.onyomis,
  });

  @override
  List<Object> get props => [kanji, kunyomis, onyomis];

  EditKanjiLoaded copyWith({
    KanjiEntity? kanji,
    List<KunyomiEntity>? kunyomis,
    List<OnyomiEntity>? onyomis,
  }) {
    return EditKanjiLoaded(
      kanji: kanji ?? this.kanji,
      kunyomis: kunyomis ?? this.kunyomis,
      onyomis: onyomis ?? this.onyomis,
    );
  }
}

class EditKanjiLoading extends EditKanjiState {}
