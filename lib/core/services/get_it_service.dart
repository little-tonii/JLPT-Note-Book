import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:note_book_app/data/datasources/admin_log_datasource.dart';
import 'package:note_book_app/data/datasources/impl/admin_log_datasource_impl.dart';
import 'package:note_book_app/data/datasources/user_datasource.dart';
import 'package:note_book_app/data/datasources/character_datasource.dart';
import 'package:note_book_app/data/datasources/impl/user_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/character_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/kanji_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/kunyomi_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/level_datasources_impl.dart';
import 'package:note_book_app/data/datasources/impl/lesson_datasource_impl.dart';
import 'package:note_book_app/data/datasources/impl/onyomi_datasource_impl.dart';
import 'package:note_book_app/data/datasources/kanji_datasource.dart';
import 'package:note_book_app/data/datasources/kunyomi_datasource.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/datasources/onyomi_datasource.dart';
import 'package:note_book_app/data/repositories/admin_log_repository_impl.dart';
import 'package:note_book_app/data/repositories/user_repository_impl.dart';
import 'package:note_book_app/data/repositories/character_repository_impl.dart';
import 'package:note_book_app/data/repositories/kanji_repository_impl.dart';
import 'package:note_book_app/data/repositories/kunyomi_repository_impl.dart';
import 'package:note_book_app/data/repositories/lesson_repository_impl.dart';
import 'package:note_book_app/data/repositories/level_repository_impl.dart';
import 'package:note_book_app/data/repositories/onyomi_repository_impl.dart';
import 'package:note_book_app/domain/repositories/admin_log_repository.dart';
import 'package:note_book_app/domain/repositories/user_repository.dart';
import 'package:note_book_app/domain/repositories/character_repository.dart';
import 'package:note_book_app/domain/repositories/kanji_repository.dart';
import 'package:note_book_app/domain/repositories/kunyomi_repository.dart';
import 'package:note_book_app/domain/repositories/lesson_repository.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';
import 'package:note_book_app/domain/repositories/onyomi_repository.dart';
import 'package:note_book_app/domain/usecases/admin_logs/create_admin_log_usecase.dart';
import 'package:note_book_app/domain/usecases/admin_logs/get_admin_logs_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/create_kanji_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/update_kanji_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/create_kunyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/update_kunyomi_by_kanji_id_usecase.dart';

import 'package:note_book_app/domain/usecases/onyomis/create_onyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/update_onyomi_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/user/get_user_infor_usecase.dart';
import 'package:note_book_app/domain/usecases/user/is_user_logged_in_usecase.dart';
import 'package:note_book_app/domain/usecases/user/login_with_email_and_password_usecase.dart';
import 'package:note_book_app/domain/usecases/user/logout_usecase.dart';
import 'package:note_book_app/domain/usecases/characters/create_character_question_usecase.dart';
import 'package:note_book_app/domain/usecases/characters/get_all_characters_usecase.dart';
import 'package:note_book_app/domain/usecases/kanjis/get_all_kanjis_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/kunyomis/get_all_kunyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_all_lessons_by_level_usecase.dart';
import 'package:note_book_app/domain/usecases/lessons/get_lesson_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_all_levels_usecase.dart';
import 'package:note_book_app/domain/usecases/levels/get_level_by_id_usecase.dart';
import 'package:note_book_app/domain/usecases/onyomis/get_all_onyomis_by_kanji_id_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_log_manager/admin_log_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web/admin_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_kanji/edit_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/login/cubits/login_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/character_page_web/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kunyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );

  getIt.registerSingleton<FirebaseAuth>(
    FirebaseAuth.instance,
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

  getIt.registerSingleton<KunyomiDatasource>(
    KunyomiDatasourceImpl(firebaseFirestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<OnyomiDatasource>(
    OnyomiDatasourceImpl(firebaseFirestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<UserDatasource>(
    UserDatasourceImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firebaseFirestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<AdminLogDatasource>(
    () => AdminLogDatasourceImpl(
      firebaseFirestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
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

  getIt.registerSingleton<KunyomiRepository>(
    KunyomiRepositoryImpl(kunyomiDatasource: getIt<KunyomiDatasource>()),
  );

  getIt.registerSingleton<OnyomiRepository>(
    OnyomiRepositoryImpl(onyomiDatasource: getIt<OnyomiDatasource>()),
  );

  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(userDatasource: getIt<UserDatasource>()),
  );

  getIt.registerLazySingleton<AdminLogRepository>(
    () => AdminLogRepositoryImpl(
      adminLogDatasource: getIt<AdminLogDatasource>(),
    ),
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

  getIt.registerSingleton<GetAllKunyomisByKanjiIdUsecase>(
    GetAllKunyomisByKanjiIdUsecase(
        kunyomiRepository: getIt<KunyomiRepository>()),
  );

  getIt.registerSingleton<GetAllOnyomisByKanjiIdUsecase>(
    GetAllOnyomisByKanjiIdUsecase(onyomiRepository: getIt<OnyomiRepository>()),
  );

  getIt.registerLazySingleton<LoginWithEmailAndPasswordUsecase>(
    () => LoginWithEmailAndPasswordUsecase(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<IsUserLoggedInUsecase>(
    () => IsUserLoggedInUsecase(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetUserInforUsecase>(
    () => GetUserInforUsecase(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateKanjiByLevelUsecase>(
    () => CreateKanjiByLevelUsecase(
      kanjiRepository: getIt<KanjiRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateKunyomiByKanjiIdUsecase>(
    () => CreateKunyomiByKanjiIdUsecase(
      kunyomiRepository: getIt<KunyomiRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateOnyomiByKanjiIdUsecase>(
    () => CreateOnyomiByKanjiIdUsecase(
      onyomiRepository: getIt<OnyomiRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateKanjiByIdUsecase>(
    () => UpdateKanjiByIdUsecase(
      kanjiRepository: getIt<KanjiRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateKunyomiByKanjiIdUsecase>(
    () => UpdateKunyomiByKanjiIdUsecase(
      kunyomiRepository: getIt<KunyomiRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateOnyomiByKanjiIdUsecase>(
    () => UpdateOnyomiByKanjiIdUsecase(
      onyomiRepository: getIt<OnyomiRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAdminLogsUsecase>(
    () => GetAdminLogsUsecase(
      adminLogRepository: getIt<AdminLogRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreateAdminLogUsecase>(
    () => CreateAdminLogUsecase(
      adminLogRepository: getIt<AdminLogRepository>(),
    ),
  );

  getIt.registerFactory(() => HomePageWebCubit());

  getIt.registerFactory(() => LevelPageWebCubit());

  getIt.registerFactory(() => DecisionRenderCubit());

  getIt.registerFactory(() => CharacterPageWebCubit());

  getIt.registerFactory(() => KanjiPageWebCubit());

  getIt.registerFactory(() => KunyomiDialogCubit());

  getIt.registerFactory(() => OnyomiDialogCubit());

  getIt.registerFactory(() => LoginPageWebCubit());

  getIt.registerFactory(() => AdminPageWebCubit());

  getIt.registerFactory(() => AdminPageSideBarCubit());

  getIt.registerFactory(() => KanjiManagerCubit());

  getIt.registerFactory(() => WordManagerCubit());

  getIt.registerFactory(() => CreateKanjiCubit());

  getIt.registerFactory(() => AdminLogManagerCubit());

  getIt.registerFactory(() => EditKanjiCubit());
}
