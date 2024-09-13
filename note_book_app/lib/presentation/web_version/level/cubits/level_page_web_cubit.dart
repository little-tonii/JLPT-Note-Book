import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_state.dart';

class LevelPageWebCubit extends Cubit<LevelPageWebState> {
  final GetAllLessonsByLevelUsecase _getAllLessonsByLevelUsecase =
      getIt<GetAllLessonsByLevelUsecase>();

  LevelPageWebCubit() : super(const LevelPageWebInitial());

  void getAllLevelDetails({required String level}) async {
    emit(const LevelPageWebLoading());
    final levelDetails = await _getAllLessonsByLevelUsecase.call(level: level);
    levelDetails.fold(
      (failure) {
        emit(LevelPageWebError(message: failure.message));
      },
      (lessons) {
        emit(LevelPageWebLoaded(lessons: lessons));
      },
    );
  }
}
