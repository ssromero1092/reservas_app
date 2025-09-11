import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/core/storage/secure_storage.dart';
import 'package:reservas_app/core/storage/shared_preferences.dart';
import 'package:reservas_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/reservas_remote_data_source.dart';
import 'package:reservas_app/features/data/repositories/auth_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/reservas_repository_impl.dart';
import 'package:reservas_app/features/domain/repositories/auth_repository.dart';
import 'package:reservas_app/features/domain/repositories/reservas_repository.dart';
import 'package:reservas_app/features/domain/usecases/login_use_case.dart';
import 'package:reservas_app/features/domain/usecases/reservas_advance_use_case.dart';
import 'package:reservas_app/features/presentation/blocs/login/login_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/reservas/reservas_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton<SharedPreferencesRepository>(
    () => SharedPreferencesRepositoryImpl(),
  );

  // Inicializa SharedPreferences
  await di<SharedPreferencesRepository>().init();

  // Core
  di.registerLazySingleton<Logger>(() => Logger());
  di.registerLazySingleton<Dio>(() => Dio());
  di.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  di.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepository(di()),
  );

  di.registerLazySingleton<DioClient>(
    () => DioClient(dio: di(), logger: di(), secureStorage: di()),
  );

  // Datasources
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<ReservasRemoteDataSource>(
    () => ReservasRemoteDataSourceImpl(dioClient: di()),
  );

  // Repositories
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: di(),
      secureStorage: di(),
      sharedRepository: di(),
    ),
  );
  di.registerLazySingleton<ReservasRepository>(
    () => ReservasRepositoryImpl(remoteDataSource: di()),
  );

  // Use Cases
  di.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: di()));
  di.registerLazySingleton<ReservasAdvanceUseCase>(
    () => ReservasAdvanceUseCase(reservasRepository: di()),
  );

  // Blocs
  di.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: di(), reservasAdvanceUseCase: di()),
  );

  di.registerFactory<ReservasBloc>(
    () => ReservasBloc(reservasAdvanceUseCase: di()),
  );
}
