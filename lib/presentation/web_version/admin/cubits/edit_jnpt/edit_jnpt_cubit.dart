import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jnpt/edit_jnpt_state.dart';

class EditJnptCubit extends Cubit<EditJnptState> {
  EditJnptCubit() : super(EditJnptInitial());

  void init() {
    emit(EditJnptLoaded());
  }
}
