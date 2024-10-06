import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/update_kanji_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/get_all_kunyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/update_kunyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/get_all_onyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/update_onyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_kanji/edit_kanji_state.dart';

class EditKanjiCubit extends Cubit<EditKanjiState> {
  final UpdateKanjiByIdUsecase _updateKanjiByIdUsecase =
      getIt<UpdateKanjiByIdUsecase>();
  final UpdateKunyomiByKanjiIdUsecase _updateKunyomiByKanjiIdUsecase =
      getIt<UpdateKunyomiByKanjiIdUsecase>();
  final UpdateOnyomiByKanjiIdUsecase _updateOnyomiByKanjiIdUsecase =
      getIt<UpdateOnyomiByKanjiIdUsecase>();
  final GetAllKunyomisByKanjiIdUsecase _getAllKunyomisByKanjiIdUsecase =
      getIt<GetAllKunyomisByKanjiIdUsecase>();
  final GetAllOnyomisByKanjiIdUsecase _getAllOnyomisByKanjiIdUsecase =
      getIt<GetAllOnyomisByKanjiIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  EditKanjiCubit() : super(EditKanjiInitial());

  void init({
    required String id,
    required String kanji,
    required String kun,
    required String on,
    required String viet,
    required Timestamp createdAt,
  }) async {
    emit(
      EditKanjiLoaded(
        kanji: KanjiEntity(
          id: id,
          kanji: kanji,
          kun: kun,
          on: on,
          viet: viet,
          createdAt: createdAt,
        ),
        kunyomis: const [],
        onyomis: const [],
      ),
    );

    final kunyomis = await _getAllKunyomisByKanjiIdUsecase.call(kanjiId: id);
    final onyomis = await _getAllOnyomisByKanjiIdUsecase.call(kanjiId: id);
    List<KunyomiEntity> kunyomiEntities = [];
    List<OnyomiEntity> onyomiEntities = [];
    bool kunyomiFailure = false;
    bool onyomiFailure = false;

    kunyomis.fold(
      (failure) {
        kunyomiFailure = true;
        emit(EditKanjiFailure(message: failure.message));
      },
      (kunyomis) {
        kunyomiEntities = kunyomis;
      },
    );

    onyomis.fold(
      (failure) {
        onyomiFailure = true;
        emit(EditKanjiFailure(message: failure.message));
      },
      (onyomis) {
        onyomiEntities = onyomis;
      },
    );

    if (onyomiFailure) {
      await _createAdminLogUsecase.call(
        message: '$id | Lỗi khi đọc Onyomis',
        action: "GET",
        actionStatus: "FAIL",
      );
    }

    if (kunyomiFailure) {
      await _createAdminLogUsecase.call(
        message: '$id | Lỗi khi đọc Kunyomis',
        action: "GET",
        actionStatus: "FAIL",
      );
    }

    if (kunyomiFailure || onyomiFailure) {
      emit(
        const EditKanjiFailure(
          message: 'Có lỗi xảy ra khi tải dữ liệu Kunyomi hoặc Onyomi',
        ),
      );
    }

    if (!kunyomiFailure && !onyomiFailure) {
      emit((state as EditKanjiLoaded).copyWith(
        kunyomis: kunyomiEntities,
        onyomis: onyomiEntities,
      ));
    }
  }
}
