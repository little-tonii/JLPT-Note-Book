import 'package:get_it/get_it.dart';
import 'package:note_book_app/data/datasources/impl/level_datasources_impl.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/repositories/level_repository_impl.dart';
import 'package:note_book_app/domain/repositories/level_repository.dart';
import 'package:note_book_app/domain/usecases/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<LevelDatasource>(
    const LevelDatasourcesImpl(),
  );

  getIt.registerSingleton<LevelRepository>(
    LevelRepositoryImpl(
      levelDatasource: getIt<LevelDatasource>(),
    ),
  );

  getIt.registerSingleton<GetAllLevelsUsecase>(
    GetAllLevelsUsecase(
      levelRepository: getIt<LevelRepository>(),
    ),
  );

  getIt.registerFactory(
    () => HomePageCubit(
      getAllLevelsUsecase: getIt<GetAllLevelsUsecase>(),
    ),
  );
}
