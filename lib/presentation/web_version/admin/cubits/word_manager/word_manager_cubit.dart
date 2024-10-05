import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_state.dart';

class WordManagerCubit extends Cubit<WordManagerState> {
  WordManagerCubit() : super(WordManagerInitial());
}
