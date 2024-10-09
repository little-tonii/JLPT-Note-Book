import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_state.dart';

class KanjiPageWebCubit extends Cubit<KanjiPageWebState> {
  final GetAllKanjisByLevelIdUsecase _getAllKanjisByLevelIdUsecase =
      getIt<GetAllKanjisByLevelIdUsecase>();

  KanjiPageWebCubit() : super(KanjiPageWebInitial());

  void getAllKanjisByLevelId({
    required String levelId,
    required String hanVietSearchKey,
    bool refresh = false,
  }) async {
    final currentState = state;
    if (currentState is KanjiPageWebLoaded && !refresh) {
      if (currentState.hasReachedMax) return;
      if (currentState.currentSearchKey != hanVietSearchKey) {
        emit(KanjiPageWebLoading());
      }
    } else if (refresh) {
      emit(KanjiPageWebLoading());
    }

    final result = await _getAllKanjisByLevelIdUsecase.call(
      levelId: levelId,
      pageSize: 10,
      pageNumber: refresh
          ? 1
          : (currentState is KanjiPageWebLoaded
              ? currentState.currentPage + 1
              : 1),
      hanVietSearchKey: hanVietSearchKey,
    );

    result.fold(
      (failure) => emit(KanjiPageWebFailure(failureMessage: failure.message)),
      (newKanjis) {
        if (currentState is KanjiPageWebLoaded) {
          if (refresh) {
            emit(KanjiPageWebLoaded(
              kanjis: newKanjis,
              hasReachedMax: newKanjis.isEmpty,
              currentPage: 1,
              currentSearchKey: hanVietSearchKey,
            ));
          } else {
            emit(KanjiPageWebLoaded(
              kanjis: currentState.kanjis + newKanjis,
              hasReachedMax: newKanjis.isEmpty,
              currentPage: currentState.currentPage + 1,
              currentSearchKey: hanVietSearchKey,
            ));
          }
        } else {
          emit(KanjiPageWebLoaded(
            kanjis: newKanjis,
            hasReachedMax: newKanjis.isEmpty,
            currentPage: 1,
            currentSearchKey: hanVietSearchKey,
          ));
        }
      },
    );
  }
}
