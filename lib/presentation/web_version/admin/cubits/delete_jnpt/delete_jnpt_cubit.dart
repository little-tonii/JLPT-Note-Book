import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jnpt/delete_jnpt_state.dart';

class DeleteJnptCubit extends Cubit<DeleteJnptState> {
  DeleteJnptCubit() : super(DeleteJnptInitial());

  void init() {
    emit(DeleteJnptLoaded());
  }
}
