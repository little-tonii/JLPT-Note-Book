import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/delete_kanji_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_kanji/delete_kanji_state.dart';

class DeleteKanjiCubit extends Cubit<DeleteKanjiState> {
  final DeleteKanjiByIdUsecase _deleteKanjiByIdUsecase =
      getIt<DeleteKanjiByIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  DeleteKanjiCubit() : super(DeleteKanjiInitial());

  void init({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
  }) {
    emit(DeleteKanjiLoaded(
      id: id,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
    ));
  }

  void deleteKanji({required String kanjiId}) async {
    emit(DeleteKanjiLoading());
    final result = await _deleteKanjiByIdUsecase.call(id: kanjiId);
    result.fold(
      (failure) {
        String message = 'Có lỗi xảy ra khi xoá Kanji';
        _createAdminLogUsecase.call(
          message: '$kanjiId | $message',
          action: "DELETE",
          actionStatus: "FAIL",
        );
        emit(DeleteKanjiFailure(message: message));
      },
      (result) {
        if (result) {
          String message = 'Xoá Kanji thành công';
          _createAdminLogUsecase.call(
            message: '$kanjiId | $message',
            action: "DELETE",
            actionStatus: "SUCCESS",
          );
          emit(
            DeleteKanjiSuccess(
              message: message,
              id: kanjiId,
            ),
          );
        } else {
          String message = 'Xoá Kanji thất bại';
          _createAdminLogUsecase.call(
            message: '$kanjiId | $message',
            action: "DELETE",
            actionStatus: "FAIL",
          );
          emit(DeleteKanjiFailure(message: message));
        }
      },
    );
  }
}
