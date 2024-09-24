import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/kunyomis/get_all_kunyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kunyomi_dialog_state.dart';

class KunyomiDialogCubit extends Cubit<KunyomiDialogState> {
  final GetAllKunyomisByKanjiIdUsecase _getAllKunyomisByKanjiIdUsecase =
      getIt<GetAllKunyomisByKanjiIdUsecase>();

  KunyomiDialogCubit() : super(KunyomiDialogInitial());

  void getAllKunyomisByKanjiId({required String kanjiId}) async {
    emit(KunyomiDialogLoading());
    final result = await _getAllKunyomisByKanjiIdUsecase.call(kanjiId: kanjiId);
    result.fold((failure) {
      emit(KunyomiDialogFailure(failureMessage: failure.message));
    }, (kunyomis) {
      emit(KunyomiDialogLoaded(kunyomis: kunyomis));
    });
  }
}
