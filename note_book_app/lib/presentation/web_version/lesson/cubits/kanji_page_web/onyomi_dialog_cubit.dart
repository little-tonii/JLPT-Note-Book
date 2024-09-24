import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/onyomis/get_all_onyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_state.dart';

class OnyomiDialogCubit extends Cubit<OnyomiDialogState> {
  final GetAllOnyomisByKanjiIdUsecase _getAllOnyomisByKanjiIdUsecase =
      getIt<GetAllOnyomisByKanjiIdUsecase>();

  OnyomiDialogCubit() : super(OnyomiDialogInitial());

  void getAllOnyomisByKanjiId({required String kanjiId}) async {
    emit(OnyomiDialogLoading());
    final result = await _getAllOnyomisByKanjiIdUsecase.call(kanjiId: kanjiId);
    result.fold((failure) {
      emit(OnyomiDialogFailure(failureMessage: failure.message));
    }, (onyomis) {
      emit(OnyomiDialogLoaded(onyomis: onyomis));
    });
  }
}
