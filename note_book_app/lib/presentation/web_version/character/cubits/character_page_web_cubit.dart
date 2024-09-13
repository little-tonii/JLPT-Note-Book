import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/get_all_characters_usecase.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_state.dart';

class CharacterPageWebCubit extends Cubit<CharacterPageWebState> {
  final GetAllCharactersUsecase getAllCharactersUsecase =
      getIt<GetAllCharactersUsecase>();

  CharacterPageWebCubit() : super(const CharacterPageWebInitial());

  void getAllCharacters() async {}
}
