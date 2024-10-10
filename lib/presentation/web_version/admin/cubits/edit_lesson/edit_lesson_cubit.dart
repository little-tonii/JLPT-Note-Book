import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/update_lesson_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_lesson/edit_lesson_state.dart';

class EditLessonCubit extends Cubit<EditLessonState> {
  final UpdateLessonByIdUsecase _updateLessonByIdUsecase =
      getIt<UpdateLessonByIdUsecase>();
  final CreateAdminLogUsecase _createAdminLogUsecase =
      getIt<CreateAdminLogUsecase>();

  EditLessonCubit() : super(EditLessonInitial());

  void init() {}
}
