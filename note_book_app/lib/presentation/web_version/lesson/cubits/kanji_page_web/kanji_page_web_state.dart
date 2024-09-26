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
  final bool hasReachedMax;
  final int currentPage;
  final String currentSearchKey;

  const KanjiPageWebLoaded({
    required this.kanjis,
    required this.hasReachedMax,
    required this.currentPage,
    required this.currentSearchKey,
  });

  @override
  List<Object> get props =>
      [kanjis, hasReachedMax, currentPage, currentSearchKey];

  KanjiPageWebLoaded copyWith({
    List<KanjiEntity>? kanjis,
    bool? hasReachedMax,
    int? currentPage,
    String? currentSearchKey,
  }) {
    return KanjiPageWebLoaded(
      kanjis: kanjis ?? this.kanjis,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentSearchKey: currentSearchKey ?? this.currentSearchKey,
    );
  }
}

class KanjiPageWebFailure extends KanjiPageWebState {
  final String failureMessage;

  const KanjiPageWebFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
