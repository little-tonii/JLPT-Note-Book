import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/lesson_manager/lesson_manager_state.dart';

class LessonManagerCubit extends Cubit<LessonManagerState> {
  LessonManagerCubit() : super(LessonManagerInitial());
}
