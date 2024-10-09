import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jlpt/edit_jlpt_state.dart';

class EditJlptCubit extends Cubit<EditJlptState> {
  EditJlptCubit() : super(EditJlptInitial());

  void init() {
    emit(EditJlptLoaded());
  }
}
