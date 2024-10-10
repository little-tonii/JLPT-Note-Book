import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_state.dart';

class CreateLessonCubit extends Cubit<CreateLessonState> {
  CreateLessonCubit() : super(CreateLessonInitial());
}
