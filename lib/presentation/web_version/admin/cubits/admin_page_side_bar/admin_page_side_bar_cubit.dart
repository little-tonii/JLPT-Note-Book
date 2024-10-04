import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/user/get_user_infor_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_state.dart';

class AdminPageSideBarCubit extends Cubit<AdminPageSideBarState> {
  final GetUserInforUsecase _getUserInforUsecase = getIt<GetUserInforUsecase>();

  AdminPageSideBarCubit() : super(AdminPageSideBarInitial());

  void getUserInfor() async {
    emit(AdminPageSideBarLoading());
    final result = await _getUserInforUsecase();
    result.fold(
      (failure) => emit(AdminPageSideBarFailure(message: failure.message)),
      (user) => emit(AdminPageSideBarLoaded(selectedIndex: 0, user: user)),
    );
  }

  void selectMenuItem(int index) {
    if (state is AdminPageSideBarLoaded) {
      final currentState = state as AdminPageSideBarLoaded;
      emit(AdminPageSideBarLoaded(
        selectedIndex: index,
        user: currentState.user,
      ));
    }
  }
}
