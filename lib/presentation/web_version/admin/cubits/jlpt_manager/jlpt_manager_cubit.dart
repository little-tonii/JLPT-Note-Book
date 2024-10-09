import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jlpt_manager/jlpt_manager_state.dart';

class JlptManagerCubit extends Cubit<JlptManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();

  JlptManagerCubit() : super(JlptManagerInitial());

  void init() async {
    emit(JlptManagerLoading());
    final levels = await _getAllLevelsUsecase.call();
    levels.fold((falure) {
      String message = 'Có lỗi xảy ra khi tải các bậc JLPT';
      emit(JlptManagerFailure(message: message));
    }, (success) {
      emit(JlptManagerLoaded(
        levels: success,
        searchValue: '',
      ));
    });
  }

  void addJlptListView({required LevelEntity jlpt}) {
    if (state is JlptManagerLoaded) {
      final currentState = state as JlptManagerLoaded;
      emit(
        currentState.copyWith(
          levels: [
            ...currentState.levels,
            jlpt,
          ],
        ),
      );
    }
  }

  void removeJlptListView({required String jlptId}) {
    if (state is JlptManagerLoaded) {
      final currentState = state as JlptManagerLoaded;
      emit(
        currentState.copyWith(
          levels: currentState.levels
              .where((element) => element.id != jlptId)
              .toList(),
        ),
      );
    }
  }

  void updateJlptListView({required LevelEntity jlpt}) {
    if (state is JlptManagerLoaded) {
      final currentState = state as JlptManagerLoaded;
      emit(
        currentState.copyWith(
          levels: currentState.levels
              .map((element) => element.id == jlpt.id ? jlpt : element)
              .toList(),
        ),
      );
    }
  }
}
