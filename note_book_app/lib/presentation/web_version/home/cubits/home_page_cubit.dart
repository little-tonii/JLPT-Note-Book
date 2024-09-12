import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/domain/usecases/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetAllLevelsUsecase getAllLevelsUsecase;

  HomePageCubit({required this.getAllLevelsUsecase})
      : super(const HomePageInitial());

  void getAllLevels() async {
    emit(const HomePageLoading());
    final levels = await getAllLevelsUsecase.call();
    levels.fold(
      (failure) {
        emit(GetAllLevelsFailure(message: failure.message));
      },
      (levels) {
        emit(GetAllLevelsSuccess(levels: levels));
      },
    );
  }
}
