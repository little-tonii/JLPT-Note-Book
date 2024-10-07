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
  final KanjiEntity kanji;
  final String message;

  const EditKanjiSuccess({required this.message, required this.kanji});

  @override
  List<Object> get props => [message, kanji];
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
  final List<String> kunyomisToDelete;
  final List<String> onyomisToDelete;

  const EditKanjiLoaded({
    required this.kanji,
    required this.kunyomis,
    required this.onyomis,
    required this.kunyomisToDelete,
    required this.onyomisToDelete,
  });

  @override
  List<Object> get props =>
      [kanji, kunyomis, onyomis, kunyomisToDelete, onyomisToDelete];

  EditKanjiLoaded copyWith({
    KanjiEntity? kanji,
    List<KunyomiEntity>? kunyomis,
    List<OnyomiEntity>? onyomis,
    List<String>? kunyomisToDelete,
    List<String>? onyomisToDelete,
  }) {
    return EditKanjiLoaded(
      kanji: kanji ?? this.kanji,
      kunyomis: kunyomis ?? this.kunyomis,
      onyomis: onyomis ?? this.onyomis,
      kunyomisToDelete: kunyomisToDelete ?? this.kunyomisToDelete,
      onyomisToDelete: onyomisToDelete ?? this.onyomisToDelete,
    );
  }
}

class EditKanjiLoading extends EditKanjiState {}
