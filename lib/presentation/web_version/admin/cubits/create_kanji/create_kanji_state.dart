import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';

abstract class CreateKanjiState extends Equatable {
  const CreateKanjiState();

  @override
  List<Object> get props => [];
}

class CreateKanjiInitial extends CreateKanjiState {}

class CreateKanjiLoading extends CreateKanjiState {}

class CreateKanjiLoaded extends CreateKanjiState {
  final KanjiEntity kanji;
  final List<OnyomiEntity> onyomis;
  final List<KunyomiEntity> kunyomis;

  const CreateKanjiLoaded({
    required this.kanji,
    required this.onyomis,
    required this.kunyomis,
  });

  @override
  List<Object> get props => [kanji, onyomis, kunyomis];

  CreateKanjiLoaded copyWith({
    KanjiEntity? kanji,
    List<OnyomiEntity>? onyomis,
    List<KunyomiEntity>? kunyomis,
  }) {
    return CreateKanjiLoaded(
      kanji: kanji ?? this.kanji,
      onyomis: onyomis ?? this.onyomis,
      kunyomis: kunyomis ?? this.kunyomis,
    );
  }
}

class CreateKanjiSuccess extends CreateKanjiState {
  final String message;

  const CreateKanjiSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateKanjiFailure extends CreateKanjiState {
  final String message;

  const CreateKanjiFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
