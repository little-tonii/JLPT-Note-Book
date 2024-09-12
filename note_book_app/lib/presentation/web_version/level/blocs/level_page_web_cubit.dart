import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/get_all_level_details_usecase.dart';
import 'package:note_book_app/presentation/web_version/level/blocs/level_page_web_state.dart';

class LevelPageWebCubit extends Cubit<LevelPageWebState> {
  final GetAllLevelDetailsUsecase getAllLevelDetailsUsecase =
      getIt<GetAllLevelDetailsUsecase>();

  LevelPageWebCubit() : super(const LevelPageWebInitial());

  void getAllLevelDetails({required String level}) async {
    emit(const LevelPageWebLoading());
    final levelDetails = await getAllLevelDetailsUsecase.call(level: level);
    levelDetails.fold(
      (failure) {
        emit(LevelPageWebError(message: failure.message));
      },
      (levelDetails) {
        emit(LevelPageWebLoaded(levelDetails: levelDetails));
      },
    );
  }
}
