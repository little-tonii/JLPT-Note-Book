import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/create_kanji_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/create_kunyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/create_onyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_state.dart';

class CreateKanjiCubit extends Cubit<CreateKanjiState> {
  final CreateKanjiByLevelUsecase _createKanjiByLevelUsecase =
      getIt<CreateKanjiByLevelUsecase>();
  final CreateKunyomiByKanjiIdUsecase _createKunyomiByKanjiIdUsecase =
      getIt<CreateKunyomiByKanjiIdUsecase>();
  final CreateOnyomiByKanjiIdUsecase _createOnyomiByKanjiIdUsecase =
      getIt<CreateOnyomiByKanjiIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  CreateKanjiCubit() : super(CreateKanjiInitial());

  void init() {
    emit(
      CreateKanjiLoaded(
        kanji: KanjiEntity(
          id: 'null',
          kanji: '',
          kun: '',
          on: '',
          viet: '',
          createdAt: Timestamp.now(),
        ),
        onyomis: const [],
        kunyomis: const [],
      ),
    );
  }

  void addKunyomi() {
    final currentState = state as CreateKanjiLoaded;
    emit(
      currentState.copyWith(
        kunyomis: [
          ...currentState.kunyomis,
          KunyomiEntity(
            id: 'null',
            meaning: '',
            sample: '',
            transform: '',
            createdAt: Timestamp.now(),
          ),
        ],
      ),
    );
  }

  void addOnyomi() {
    final currentState = state as CreateKanjiLoaded;
    emit(
      currentState.copyWith(
        onyomis: [
          ...currentState.onyomis,
          OnyomiEntity(
            id: 'null',
            meaning: '',
            sample: '',
            transform: '',
            createdAt: Timestamp.now(),
          ),
        ],
      ),
    );
  }

  void removeKunyomi({required int index}) {
    if (state is CreateKanjiLoaded) {
      final currentState = state as CreateKanjiLoaded;
      emit(
        currentState.copyWith(
          kunyomis: List.from(currentState.kunyomis)..removeAt(index),
        ),
      );
    }
  }

  void removeOnyomi({required int index}) {
    if (state is CreateKanjiLoaded) {
      final currentState = state as CreateKanjiLoaded;
      emit(
        currentState.copyWith(
          onyomis: List.from(currentState.onyomis)..removeAt(index),
        ),
      );
    }
  }

  void createKanji({
    required String level,
    required String kanji,
    required String viet,
    required String kun,
    required String on,
    required List<String> sampleKunyomi,
    required List<String> transformKunyomi,
    required List<String> meaningKunyomi,
    required List<String> sampleOnyomi,
    required List<String> transformOnyomi,
    required List<String> meaningOnyomi,
  }) async {
    emit(CreateKanjiLoading());
    final kanjiCreated = await _createKanjiByLevelUsecase.call(
      level: level,
      kanji: kanji,
      kun: kun,
      on: on,
      viet: viet,
    );
    kanjiCreated.fold(
      (failure) {
        const message = 'Không thể tạo mới kanji';
        emit(
          const CreateKanjiFailure(message: message),
        );
        _createAdminLogUsecase.call(
          message: 'null | $message',
          action: 'CREATE',
          actionStatus: 'FAILED',
        );
      },
      (success) async {
        final kanjiId = success.id;
        int kunyomiError = 0;
        int onyomiError = 0;
        for (int i = 0; i < sampleKunyomi.length; i++) {
          final kunyomiCreated = await _createKunyomiByKanjiIdUsecase.call(
            kanjiId: kanjiId,
            meaning: meaningKunyomi[i],
            sample: sampleKunyomi[i],
            transform: transformKunyomi[i],
          );
          kunyomiCreated.fold(
            (failure) {
              kunyomiError++;
            },
            (success) {},
          );
        }
        for (int i = 0; i < sampleOnyomi.length; i++) {
          final onyomiCreated = await _createOnyomiByKanjiIdUsecase.call(
            kanjiId: kanjiId,
            meaning: meaningOnyomi[i],
            sample: sampleOnyomi[i],
            transform: transformOnyomi[i],
          );
          onyomiCreated.fold(
            (failure) {
              onyomiError++;
            },
            (success) {},
          );
        }
        if (kunyomiError == 0 && onyomiError == 0) {
          const message = 'Tạo mới kanji thành công';
          emit(const CreateKanjiSuccess(message: message));
          await _createAdminLogUsecase.call(
            message: '$kanjiId | $message',
            action: 'CREATE',
            actionStatus: 'SUCCESS',
          );
        } else {
          final message =
              'Có lỗi trong quá trình tạo mới kanji. $kunyomiError lỗi khi tạo kunyomi, $onyomiError lỗi khi tạo onyomi';
          emit(CreateKanjiFailure(message: message));
          await _createAdminLogUsecase.call(
            message: '$kanjiId | $message',
            action: 'CREATE',
            actionStatus: 'FAILED',
          );
        }
      },
    );
  }
}
