import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/data/datasources/impl/character_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/kanji_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/level_datasources_impl.dart';
import 'package:note_book_app/data/datasources/impl/lesson_datasource_impl.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/repositories/character_repository_impl.dart';
import 'package:note_book_app/data/repositories/kanji_repository_impl.dart';
import 'package:note_book_app/data/repositories/lesson_repository_impl.dart';
import 'package:note_book_app/data/repositories/level_repository_impl.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';
import 'package:note_book_app/domain/usecases/characters/create_character_question_usecase.dart';
import 'package:note_book_app/domain/usecases/characters/get_all_characters_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_lesson_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_level_by_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/character_page_web/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );

  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<LevelDatasource>(
    LevelDatasourcesImpl(
      firebaseFirestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerSingleton<LessonDatasource>(
    LessonDatasourceImpl(firebaseFirestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<CharacterDatasource>(CharacterDatasourceImpl(
    firebaseFirestore: getIt<FirebaseFirestore>(),
  ));

  getIt.registerSingleton<KanjiDatasource>(
    KanjiDatasourceImpl(firebaseFirestore: getIt<FirebaseFirestore>()),
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

  getIt.registerSingleton<KanjiRepository>(
    KanjiRepositoryImpl(kanjiDatasource: getIt<KanjiDatasource>()),
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

  getIt.registerSingleton<GetLevelByIdUsecase>(
    GetLevelByIdUsecase(levelRepository: getIt<LevelRepository>()),
  );

  getIt.registerSingleton<GetLessonByIdUsecase>(
    GetLessonByIdUsecase(lessonRepository: getIt<LessonRepository>()),
  );

  getIt.registerSingleton<GetAllKanjisByLevelUsecase>(
    GetAllKanjisByLevelUsecase(kanjiRepository: getIt<KanjiRepository>()),
  );

  getIt.registerFactory(() => HomePageWebCubit());

  getIt.registerFactory(() => LevelPageWebCubit());

  getIt.registerFactory(() => DecisionRenderCubit());

  getIt.registerFactory(() => CharacterPageWebCubit());

  getIt.registerFactory(() => KanjiPageWebCubit());
}
