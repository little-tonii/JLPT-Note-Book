import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/characters/get_all_characters_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/character_page_web/character_page_web_state.dart';

class CharacterPageWebCubit extends Cubit<CharacterPageWebState> {
  final GetAllCharactersUsecase _getAllCharactersUsecase =
      getIt<GetAllCharactersUsecase>();

  CharacterPageWebCubit() : super(CharacterPageWebInitial());

  void getAllCharacters({required String characterType}) async {
    emit(CharacterPageWebLoading());
    final result = await _getAllCharactersUsecase.call();
    result.fold(
      (failure) =>
          emit(CharacterPageWebFailure(failureMessage: failure.message)),
      (characters) => emit(CharacterPageWebLoaded(
        characters: characters,
        characterType: characterType,
      )),
    );
  }
}
