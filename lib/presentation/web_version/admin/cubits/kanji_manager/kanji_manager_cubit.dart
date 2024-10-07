import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';

class KanjiManagerCubit extends Cubit<KanjiManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();
  final GetAllKanjisByLevelUsecase _getAllKanjisByLevelUsecase =
      getIt<GetAllKanjisByLevelUsecase>();

  KanjiManagerCubit() : super(KanjiManagerInitial());

  void updateFilterChoice({String? level}) async {
    if (state is KanjiManagerInitial) {
      final levels = await _getAllLevelsUsecase.call();
      levels.fold(
        (failure) => emit(KanjiManagerFailure(message: failure.message)),
        (result) => emit(KanjiManagerLoaded(
          kanjis: const [],
          levels: result,
          levelFilterState: '',
        )),
      );
    }
    if (state is KanjiManagerLoaded) {
      String levelFilter = level ?? '';
      if (levelFilter.isNotEmpty) {
        final kanjis = await _getAllKanjisByLevelUsecase.call(
          pageNumber: 0,
          pageSize: 20,
          level: levelFilter,
          hanVietSearchKey: '',
        );
        kanjis.fold(
          (failure) => emit(KanjiManagerFailure(message: failure.message)),
          (result) {
            final currentState = state as KanjiManagerLoaded;
            emit(KanjiManagerLoaded(
              hasReachedMax: result.length < 20,
              kanjis: result,
              levels: currentState.levels,
              levelFilterState: levelFilter,
              searchKey: '',
            ));
          },
        );
      }
    }
  }

  void searchKanjis({
    required String hanVietSearchKey,
    bool refresh = false,
  }) async {
    if (state is KanjiManagerLoaded) {
      final currentState = state as KanjiManagerLoaded;
      if (refresh) {
        final kanjis = await _getAllKanjisByLevelUsecase.call(
          level: currentState.levelFilterState,
          pageNumber: 0,
          pageSize: 20,
          hanVietSearchKey: hanVietSearchKey,
        );
        kanjis.fold(
          (failure) => emit(KanjiManagerFailure(message: failure.message)),
          (result) {
            emit(KanjiManagerLoaded(
              kanjis: result,
              levels: currentState.levels,
              levelFilterState: currentState.levelFilterState,
              hasReachedMax: result.length < 20,
              searchKey: hanVietSearchKey,
            ));
          },
        );
      } else {
        if (!currentState.hasReachedMax) {
          final kanjis = await _getAllKanjisByLevelUsecase.call(
            level: currentState.levelFilterState,
            pageNumber: currentState.kanjis.length ~/ 20 + 1,
            pageSize: 20,
            hanVietSearchKey: hanVietSearchKey,
          );
          kanjis.fold(
            (failure) => emit(KanjiManagerFailure(message: failure.message)),
            (result) {
              emit(currentState.copyWith(
                kanjis: List.of(currentState.kanjis)..addAll(result),
                hasReachedMax: result.length < 20,
                searchKey: hanVietSearchKey,
              ));
            },
          );
        }
      }
    }
  }

  void deleteKanjiByIdView({required String id}) {
    if (state is KanjiManagerLoaded) {
      final currentState = state as KanjiManagerLoaded;
      final kanjis =
          currentState.kanjis.where((kanji) => kanji.id != id).toList();
      emit(currentState.copyWith(kanjis: kanjis));
    }
  }

  void createKanjiView({required KanjiEntity kanji}) {
    if (state is KanjiManagerLoaded) {
      final currentState = state as KanjiManagerLoaded;
      emit(
        currentState.copyWith(kanjis: List.of(currentState.kanjis)..add(kanji)),
      );
    }
  }

  void updateKanjiView({required KanjiEntity kanji}) {
    if (state is KanjiManagerLoaded) {
      final currentState = state as KanjiManagerLoaded;
      final kanjis = currentState.kanjis.map((kanjiItem) {
        if (kanjiItem.id == kanji.id) {
          return kanji;
        }
        return kanjiItem;
      }).toList();
      emit(currentState.copyWith(kanjis: kanjis));
    }
  }
}
