import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jnpt_manager/jnpt_manager_state.dart';

class JnptManagerCubit extends Cubit<JnptManagerState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();

  JnptManagerCubit() : super(JnptManagerInitial());

  void init() async {
    emit(JnptManagerLoading());
    final levels = await _getAllLevelsUsecase.call();
    levels.fold((falure) {
      String message = 'Có lỗi xảy ra khi tải các bậc JNPT';
      emit(JnptManagerFailure(message: message));
    }, (success) {
      emit(JnptManagerLoaded(
        levels: success,
        searchValue: '',
      ));
    });
  }

  void addJnptListView({required LevelEntity jnpt}) {
    if (state is JnptManagerLoaded) {
      final currentState = state as JnptManagerLoaded;
      emit(
        currentState.copyWith(
          levels: [
            ...currentState.levels,
            jnpt,
          ],
        ),
      );
    }
  }

  void removeJnptListView({required String jnptId}) {
    if (state is JnptManagerLoaded) {
      final currentState = state as JnptManagerLoaded;
      emit(
        currentState.copyWith(
          levels: currentState.levels
              .where((element) => element.id != jnptId)
              .toList(),
        ),
      );
    }
  }
}
