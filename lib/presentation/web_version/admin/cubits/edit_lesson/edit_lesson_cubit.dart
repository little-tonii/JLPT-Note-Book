import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_lesson/edit_lesson_state.dart';

class EditLessonCubit extends Cubit<EditLessonState> {
  EditLessonCubit() : super(EditLessonInitial());
}
