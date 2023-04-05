import 'package:get_it/get_it.dart';
import 'package:github_challenge/modules/saved_repositories/cubit/saved_repositories_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository_impl.dart';
import 'package:github_challenge/core/services/database_service.dart';
import 'package:github_challenge/modules/home/cubit/home_cubit.dart';
import 'package:github_challenge/modules/login/cubit/login_cubit.dart';

import '../repositories/database_repository/database_repository.dart';
import '../repositories/database_repository/database_repository_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //User Repository DI
  if (!locator.isRegistered<UserRepository>()) {
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(),
    );
  }
  //databaseService DI
  locator.registerSingletonAsync<DatabaseService>(() async {
    final databaseService = DatabaseService.instance;
    await databaseService.database;
    return databaseService;
  });
  //Database Repository DI
  locator.registerLazySingleton<DatabaseRepository>(
    () => DatabaseRepositoryImpl(
      databaseService: locator<DatabaseService>(),
    ),
  );
  //HomeCubit DI
  locator.registerFactory<HomeCubit>(
    () => HomeCubit(
      userRepository: locator<UserRepository>(),
    ),
  );
  //google sign in DI
  locator.registerFactory<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ),
  );
  //LoginCubit DI
  locator.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );

  //SavedRepositoriesCubit DI
  locator.registerFactory<SavedRepositoriesCubit>(
    () => SavedRepositoriesCubit(
      databaseRepository: locator<DatabaseRepository>(),
    ),
  );
}
