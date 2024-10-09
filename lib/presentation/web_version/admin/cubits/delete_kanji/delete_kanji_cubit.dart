import 'package:cloud_firestore/cloud_firestore.dart';
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
    required Timestamp createdAt,
  }) {
    emit(DeleteKanjiLoaded(
      id: id,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
      createdAt: createdAt,
    ));
  }

  void deleteKanji({required String kanjiId}) async {
    String id = '';
    String kanji = '';
    String viet = '';
    String kun = '';
    String on = '';
    String createdAt = '';
    if (state is DeleteKanjiLoaded) {
      final currentState = state as DeleteKanjiLoaded;
      kanji = currentState.kanji;
      viet = currentState.viet;
      kun = currentState.kun;
      on = currentState.on;
      createdAt = currentState.createdAt.toDate().toLocal().toString();
      id = currentState.id;
    }
    emit(DeleteKanjiLoading());
    final result = await _deleteKanjiByIdUsecase.call(id: kanjiId);
    result.fold(
      (failure) async {
        await _createAdminLogUsecase.call(
          message: '$kanjiId | ${failure.message}',
          action: "DELETE",
          actionStatus: "FAILED",
        );
        emit(DeleteKanjiFailure(message: failure.message));
      },
      (result) async {
        if (result) {
          String message = 'Xoá Kanji thành công';
          await _createAdminLogUsecase.call(
            message:
                '{ id: "$id", kanji: "$kanji", kun: "$kun", on: "$on", viet: "$viet", createdAt: "$createdAt" } | $message',
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
          await _createAdminLogUsecase.call(
            message: '$kanjiId | $message',
            action: "DELETE",
            actionStatus: "FAILED",
          );
          emit(DeleteKanjiFailure(message: message));
        }
      },
    );
  }
}
