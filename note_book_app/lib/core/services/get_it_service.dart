import 'package:get_it/get_it.dart';
import 'package:note_book_app/data/datasources/impl/level_datasources_impl.dart';
import 'package:note_book_app/data/datasources/impl/level_details_datasource_impl.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/datasources/level_details_datasource.dart';
import 'package:note_book_app/data/repositories/level_details_repository_impl.dart';
import 'package:note_book_app/data/repositories/level_repository_impl.dart';
import 'package:note_book_app/domain/repositories/level_details_repository.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';
import 'package:note_book_app/domain/usecases/get_all_level_details_usecase.dart';
import 'package:note_book_app/domain/usecases/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<LevelDatasource>(
    const LevelDatasourcesImpl(),
  );

  getIt.registerSingleton<LevelDetailsDatasource>(
    const LevelDetailsDatasourceImpl(),
  );

  getIt.registerSingleton<LevelRepository>(
    LevelRepositoryImpl(
      levelDatasource: getIt<LevelDatasource>(),
    ),
  );

  getIt.registerSingleton<LevelDetailsRepository>(LevelDetailsRepositoryImpl(
      levelDetailsDatasource: getIt<LevelDetailsDatasource>()));

  getIt.registerSingleton<GetAllLevelsUsecase>(
    GetAllLevelsUsecase(
      levelRepository: getIt<LevelRepository>(),
    ),
  );

  getIt.registerSingleton<GetAllLevelDetailsUsecase>(GetAllLevelDetailsUsecase(
    levelDetailsRepository: getIt<LevelDetailsRepository>(),
  ));

  getIt.registerFactory(
    () => HomePageWebCubit(
      getAllLevelsUsecase: getIt<GetAllLevelsUsecase>(),
    ),
  );
}
