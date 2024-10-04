import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class KanjiManagerState extends Equatable {
  const KanjiManagerState();

  @override
  List<Object?> get props => [];
}

class KanjiManagerInitial extends KanjiManagerState {}

class KanjiManagerFailure extends KanjiManagerState {
  final String message;

  const KanjiManagerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class KanjiManagerLoaded extends KanjiManagerState {
  final String levelFilterState;
  final List<LevelEntity> levels;
  final List<KanjiEntity> kanjis;
  final bool hasReachedMax;
  final String searchKey;

  const KanjiManagerLoaded({
    required this.levelFilterState,
    required this.levels,
    required this.kanjis,
    this.hasReachedMax = false,
    this.searchKey = '',
  });

  @override
  List<Object?> get props => [
        levels,
        levelFilterState,
        kanjis,
        hasReachedMax,
        searchKey,
      ];

  KanjiManagerLoaded copyWith({
    String? levelFilterState,
    List<LevelEntity>? levels,
    List<KanjiEntity>? kanjis,
    bool? hasReachedMax,
    String? searchKey,
  }) {
    return KanjiManagerLoaded(
      levelFilterState: levelFilterState ?? this.levelFilterState,
      levels: levels ?? this.levels,
      kanjis: kanjis ?? this.kanjis,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchKey: searchKey ?? this.searchKey,
    );
  }
}
