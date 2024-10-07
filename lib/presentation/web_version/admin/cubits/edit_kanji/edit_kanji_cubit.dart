import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/update_kanji_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/create_kunyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/get_all_kunyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/update_kunyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/create_onyomi_by_kanji_id_usecase.dart';
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
  final CreateOnyomiByKanjiIdUsecase _createOnyomiByKanjiIdUsecase =
      getIt<CreateOnyomiByKanjiIdUsecase>();
  final CreateKunyomiByKanjiIdUsecase _createKunyomiByKanjiIdUsecase =
      getIt<CreateKunyomiByKanjiIdUsecase>();

  EditKanjiCubit() : super(EditKanjiInitial());

  void updateKanji({
    required String kanji,
    required String kun,
    required String on,
    required String viet,
    required List<String> sampleKunyomis,
    required List<String> sampleOnyomis,
    required List<String> meaningsKunyomis,
    required List<String> meaningsOnyomis,
    required List<String> transformsKunyomis,
    required List<String> transformsOnyomis,
  }) async {
    if (state is EditKanjiLoaded) {
      final currentState = state as EditKanjiLoaded;
      List<KunyomiEntity> kunyomis = currentState.kunyomis;
      List<OnyomiEntity> onyomis = currentState.onyomis;
      KanjiEntity updatingKanji = currentState.kanji;
      emit(EditKanjiLoading());
      final updatedKanji = await _updateKanjiByIdUsecase.call(
        kanji: kanji,
        kun: kun,
        on: on,
        viet: viet,
        id: updatingKanji.id,
      );
      updatedKanji.fold(
        (failure) {
          String message = 'Có lỗi xảy ra khi cập nhật Kanji';
          emit(EditKanjiFailure(message: failure.message));
          _createAdminLogUsecase.call(
            message: '${updatingKanji.id} | $message',
            action: "UPDATE",
            actionStatus: "FAIL",
          );
        },
        (success) async {
          if (!success) {
            String message = 'Cập nhật Kanji không thành công';
            emit(EditKanjiFailure(message: message));
            _createAdminLogUsecase.call(
              message: '${updatingKanji.id} | $message',
              action: "UPDATE",
              actionStatus: "FAIL",
            );
          } else {
            int kunyomiFailure = 0;
            int onyomiFailure = 0;
            for (int i = 0; i < kunyomis.length; i++) {
              if (kunyomis[i].id == 'null') {
                final kunyomiCreated =
                    await _createKunyomiByKanjiIdUsecase.call(
                  kanjiId: updatingKanji.id,
                  meaning: meaningsKunyomis[i],
                  sample: sampleKunyomis[i],
                  transform: transformsKunyomis[i],
                );
                kunyomiCreated.fold(
                  (failure) {
                    kunyomiFailure++;
                  },
                  (success) {
                    if (!success) {
                      kunyomiFailure++;
                    }
                  },
                );
              } else {
                final kunyomiUpdated =
                    await _updateKunyomiByKanjiIdUsecase.call(
                  kanjiId: updatingKanji.id,
                  kunyomiId: kunyomis[i].id,
                  meaning: meaningsKunyomis[i],
                  sample: sampleKunyomis[i],
                  transform: transformsKunyomis[i],
                );
                kunyomiUpdated.fold(
                  (failure) {
                    kunyomiFailure++;
                  },
                  (success) {
                    if (!success) {
                      kunyomiFailure++;
                    }
                  },
                );
              }
            }
            for (int i = 0; i < onyomis.length; i++) {
              if (onyomis[i].id == 'null') {
                final onyomiCreated = await _createOnyomiByKanjiIdUsecase.call(
                  kanjiId: updatingKanji.id,
                  meaning: meaningsOnyomis[i],
                  sample: sampleOnyomis[i],
                  transform: transformsOnyomis[i],
                );
                onyomiCreated.fold(
                  (failure) {
                    onyomiFailure++;
                  },
                  (success) {
                    if (!success) {
                      onyomiFailure++;
                    }
                  },
                );
              } else {
                final onyomiUpdated = await _updateOnyomiByKanjiIdUsecase.call(
                  kanjiId: updatingKanji.id,
                  onyomiId: onyomis[i].id,
                  meaning: meaningsOnyomis[i],
                  sample: sampleOnyomis[i],
                  transform: transformsOnyomis[i],
                );
                onyomiUpdated.fold(
                  (failure) {
                    onyomiFailure++;
                  },
                  (success) {
                    if (!success) {
                      onyomiFailure++;
                    }
                  },
                );
              }
            }
            if (kunyomiFailure > 0 || onyomiFailure > 0) {
              String message = 'Có lỗi xảy ra khi cập nhật Kunyomi hoặc Onyomi';
              emit(EditKanjiFailure(message: message));
              _createAdminLogUsecase.call(
                message:
                    '${updatingKanji.id} | $message. $kunyomiFailure lỗi khi cập nhật Kunyomi, $onyomiFailure lỗi khi cập nhật Onyomi',
                action: "UPDATE",
                actionStatus: "FAIL",
              );
            } else {
              String message = 'Cập nhật Kanji thành công';
              emit(
                EditKanjiSuccess(
                  message: message,
                  kanji: KanjiEntity(
                    id: updatingKanji.id,
                    kanji: kanji,
                    kun: kun,
                    on: on,
                    viet: viet,
                    createdAt: updatingKanji.createdAt,
                  ),
                ),
              );
              _createAdminLogUsecase.call(
                message: '${updatingKanji.id} | $message',
                action: "UPDATE",
                actionStatus: "SUCCESS",
              );
            }
          }
        },
      );
    }
  }

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

  void addMoreKunyomi() {
    if (state is EditKanjiLoaded) {
      final currentState = state as EditKanjiLoaded;
      emit(
        currentState.copyWith(
          kunyomis: List.of(currentState.kunyomis)
            ..add(
              KunyomiEntity(
                id: 'null',
                transform: '',
                meaning: '',
                sample: '',
                createdAt: Timestamp.now(),
              ),
            ),
        ),
      );
    }
  }

  void addMoreOnyomi() {
    if (state is EditKanjiLoaded) {
      final currentState = state as EditKanjiLoaded;
      emit(
        currentState.copyWith(
          onyomis: List.of(currentState.onyomis)
            ..add(
              OnyomiEntity(
                id: 'null',
                transform: '',
                meaning: '',
                sample: '',
                createdAt: Timestamp.now(),
              ),
            ),
        ),
      );
    }
  }

  void removeKunyomi({required int index}) {
    if (state is EditKanjiLoaded) {
      final currentState = state as EditKanjiLoaded;
      emit(
        currentState.copyWith(
          kunyomis: List.from(currentState.kunyomis)..removeAt(index),
        ),
      );
    }
  }

  void removeOnyomi({required int index}) {
    if (state is EditKanjiLoaded) {
      final currentState = state as EditKanjiLoaded;
      emit(
        currentState.copyWith(
          onyomis: List.from(currentState.onyomis)..removeAt(index),
        ),
      );
    }
  }
}
