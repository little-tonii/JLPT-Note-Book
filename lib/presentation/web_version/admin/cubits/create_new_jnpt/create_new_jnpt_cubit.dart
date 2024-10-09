import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jnpt/create_new_jnpt_state.dart';

class CreateNewJnptCubit extends Cubit<CreateNewJnptState> {
  CreateNewJnptCubit() : super(CreateNewJnptInitial());

  void init() {}
}
