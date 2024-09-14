import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/get_all_characters_usecase.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_state.dart';

class CharacterPageWebCubit extends Cubit<CharacterPageWebState> {
  final GetAllCharactersUsecase getAllCharactersUsecase =
      getIt<GetAllCharactersUsecase>();
  bool showHigarana = true;

  CharacterPageWebCubit() : super(const CharacterPageWebInitial());

  void getAllCharacters() async {
    emit(const CharacterPageWebLoading());
    final result = await getAllCharactersUsecase.call();
    result.fold(
      (failure) => emit(CharacterPageWebError(message: failure.message)),
      (characters) => emit(CharacterPageWebLoaded(characters: characters)),
    );
  }

  void changeCharacterType({required String type}) async {
    if (type == 'Hiragana') {
      showHigarana = true;
    } else {
      showHigarana = false;
    }
    getAllCharacters();
  }

  void startQuestionsPhase() {
    emit(const QuestionPhase());
  }
}
