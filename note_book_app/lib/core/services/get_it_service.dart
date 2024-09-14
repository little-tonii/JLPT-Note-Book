import 'package:get_it/get_it.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/data/datasources/impl/character_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/level_datasources_impl.dart';
import 'package:note_book_app/data/datasources/impl/lesson_datasource_impl.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/repositories/character_repository_impl.dart';
import 'package:note_book_app/data/repositories/lesson_repository_impl.dart';
import 'package:note_book_app/data/repositories/level_repository_impl.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';
import 'package:note_book_app/domain/usecases/create_character_question_usecase.dart';
import 'package:note_book_app/domain/usecases/get_all_characters_usecase.dart';
import 'package:note_book_app/domain/usecases/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<LevelDatasource>(
    const LevelDatasourcesImpl(),
  );

  getIt.registerSingleton<LessonDatasource>(
    const LessonDatasourceImpl(),
  );

  getIt.registerSingleton<CharacterDatasource>(
    const CharacterDatasourceImpl(),
  );

  getIt.registerSingleton<LevelRepository>(
    LevelRepositoryImpl(
      levelDatasource: getIt<LevelDatasource>(),
    ),
  );

  getIt.registerSingleton<LessonRepository>(
    LessonRepositoryImpl(lessonDatasource: getIt<LessonDatasource>()),
  );

  getIt.registerSingleton<CharacterRepository>(
    CharacterRepositoryImpl(characterDatasource: getIt<CharacterDatasource>()),
  );

  getIt.registerSingleton<GetAllLevelsUsecase>(
    GetAllLevelsUsecase(
      levelRepository: getIt<LevelRepository>(),
    ),
  );

  getIt.registerSingleton<GetAllLessonsByLevelUsecase>(
      GetAllLessonsByLevelUsecase(
    lessonRepository: getIt<LessonRepository>(),
  ));

  getIt.registerSingleton<GetAllCharactersUsecase>(
    GetAllCharactersUsecase(characterRepository: getIt<CharacterRepository>()),
  );

  getIt.registerSingleton<CreateCharacterQuestionUsecase>(
    CreateCharacterQuestionUsecase(
        characterRepository: getIt<CharacterRepository>()),
  );

  getIt.registerFactory(() => HomePageWebCubit());

  getIt.registerFactory(() => LevelPageWebCubit());

  getIt.registerFactory(() => CharacterPageWebCubit());

  getIt.registerFactory(() => CharacterQuestionPhaseWebCubit());
}
