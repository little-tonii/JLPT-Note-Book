import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/user/is_logged_in_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web_state.dart';

class AdminPageWebCubit extends Cubit<AdminPageWebState> {
  final IsLoggedInUsecase _isLoggedInUsecase = getIt<IsLoggedInUsecase>();

  AdminPageWebCubit() : super(AdminPageWebLoading());

  void checkIfUserIsLoggedIn() async {
    final result = await _isLoggedInUsecase.call();
    result.fold(
      (failure) => emit(AdminPageWebUserNotLoggedIn()),
      (user) => emit(AdminPageWebInitial()),
    );
  }
}
