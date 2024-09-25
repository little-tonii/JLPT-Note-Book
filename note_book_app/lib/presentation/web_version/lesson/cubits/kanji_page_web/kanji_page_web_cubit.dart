import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_state.dart';

class KanjiPageWebCubit extends Cubit<KanjiPageWebState> {
  final GetAllKanjisByLevelUsecase _getAllKanjisByLevelUsecase =
      getIt<GetAllKanjisByLevelUsecase>();

  KanjiPageWebCubit() : super(KanjiPageWebInitial());

  void getAllKanjisByLevel({required String levelId}) async {
    emit(KanjiPageWebLoading());
    final result = await _getAllKanjisByLevelUsecase.call(
      level: levelId,
      pageSize: 10,
      pageNumber: 1,
    );
    result.fold((failure) {
      emit(KanjiPageWebFailure(failureMessage: failure.message));
    }, (kanjis) {
      emit(KanjiPageWebLoaded(kanjis: kanjis));
    });
  }
}
