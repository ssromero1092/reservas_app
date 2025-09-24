import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/core/storage/secure_storage.dart';
import 'package:reservas_app/core/storage/shared_preferences.dart';
import 'package:reservas_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/habitacion_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/recinto_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/reservas_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/tipo_hospedaje_remote_data_source.dart';
import 'package:reservas_app/features/data/datasources/tipo_precio_remote_data_source.dart';
import 'package:reservas_app/features/data/repositories/auth_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/habitacion_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/recinto_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/reservas_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/tipo_hospedaje_repository_impl.dart';
import 'package:reservas_app/features/data/repositories/tipo_precio_repository_impl.dart';
import 'package:reservas_app/features/domain/repositories/auth_repository.dart';
import 'package:reservas_app/features/domain/repositories/habitacion_repository.dart';
import 'package:reservas_app/features/domain/repositories/recinto_repository.dart';
import 'package:reservas_app/features/domain/repositories/reservas_repository.dart';
import 'package:reservas_app/features/domain/repositories/tipo_hospedaje_repository.dart';
import 'package:reservas_app/features/domain/repositories/tipo_precio_repository.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/create_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/delete_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/get_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/update_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/login_use_case.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/create_recinto_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/delete_recinto_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/get_recintos_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/update_recinto_usecase.dart';
import 'package:reservas_app/features/domain/usecases/reservas_advance_use_case.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/create_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/delete_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/get_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/update_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/create_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/delete_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/get_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/update_tipo_precio_usecase.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/login/login_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/reservas/reservas_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';

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
  
  // Storage
  di.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  di.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepository(di()),
  );

  di.registerLazySingleton<DioClient>(() => DioClient(
    dio: di(),
    logger: di(),
    secureStorage: di(),
  ));

  // Data Sources
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: di()),
  );

  di.registerLazySingleton<ReservasRemoteDataSource>(
    () => ReservasRemoteDataSourceImpl(dioClient: di()),
  );

  di.registerLazySingleton<RecintoRemoteDataSource>(
    () => RecintoRemoteDataSourceImpl(dioClient: di()),
  );

  di.registerLazySingleton<HabitacionRemoteDataSource>(
    () => HabitacionRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<TipoHospedajeRemoteDataSource>(
    () => TipoHospedajeRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<TipoPrecioRemoteDataSource>(
    () => TipoPrecioRemoteDataSourceImpl(dioClient: di()),
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

  di.registerLazySingleton<RecintoRepository>(
    () => RecintoRepositoryImpl(remoteDataSource: di()),
  );

  di.registerLazySingleton<HabitacionRepository>(
    () => HabitacionRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<TipoHospedajeRepository>(
    () => TipoHospedajeRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<TipoPrecioRepository>(
    () => TipoPrecioRepositoryImpl(remoteDataSource: di()),
  );
  

  // Use Cases
  di.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: di()));
  di.registerLazySingleton<ReservasAdvanceUseCase>(
    () => ReservasAdvanceUseCase(reservasRepository: di()),
  );

  // Recinto Use Cases
  di.registerLazySingleton<GetRecintosUseCase>(
    () => GetRecintosUseCase(recintoRepository: di()),
  );
  di.registerLazySingleton<CreateRecintoUseCase>(
    () => CreateRecintoUseCase(recintoRepository: di()),
  );
  di.registerLazySingleton<UpdateRecintoUseCase>(
    () => UpdateRecintoUseCase(recintoRepository: di()),
  );
  di.registerLazySingleton<DeleteRecintoUseCase>(
    () => DeleteRecintoUseCase(recintoRepository: di()),
  );

  // Habitacion Use Cases
  di.registerLazySingleton<GetHabitacionesUseCase>(
    () => GetHabitacionesUseCase(habitacionRepository: di()),
  );
  di.registerLazySingleton<CreateHabitacionUseCase>(
    () => CreateHabitacionUseCase(habitacionRepository: di()),
  );
  di.registerLazySingleton<UpdateHabitacionUseCase>(
    () => UpdateHabitacionUseCase(habitacionRepository: di()),
  );
  di.registerLazySingleton<DeleteHabitacionUseCase>(
    () => DeleteHabitacionUseCase(habitacionRepository: di()),
  );

  // TipoHospedaje Use Cases
  di.registerLazySingleton<GetTipoHospedajesUseCase>(
    () => GetTipoHospedajesUseCase(tipoHospedajeRepository: di()),
  );
  di.registerLazySingleton<CreateTipoHospedajeUseCase>(
    () => CreateTipoHospedajeUseCase(tipoHospedajeRepository: di()),
  );
  di.registerLazySingleton<UpdateTipoHospedajeUseCase>(
    () => UpdateTipoHospedajeUseCase(tipoHospedajeRepository: di()),
  );
  di.registerLazySingleton<DeleteTipoHospedajeUseCase>(
    () => DeleteTipoHospedajeUseCase(tipoHospedajeRepository: di()),
  );

  // TipoPrecio Use Cases
  di.registerLazySingleton<GetTipoPreciosUseCase>(
    () => GetTipoPreciosUseCase(tipoPrecioRepository: di()),
  );
  di.registerLazySingleton<CreateTipoPrecioUseCase>(
    () => CreateTipoPrecioUseCase(tipoPrecioRepository: di()),
  );
  di.registerLazySingleton<UpdateTipoPrecioUseCase>(
    () => UpdateTipoPrecioUseCase(tipoPrecioRepository: di()),
  );
  di.registerLazySingleton<DeleteTipoPrecioUseCase>(
    () => DeleteTipoPrecioUseCase(tipoPrecioRepository: di()),
  );

  // Blocs
  di.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      secureStorage: di(),
      sharedPreferences: di(),
      loginUseCase: di(), // Agregar LoginUseCase aquí
    ),
  );

  di.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: di(),
      reservasAdvanceUseCase: di(),
    ),
  );

  di.registerFactory<ReservasBloc>(
    () => ReservasBloc(reservasAdvanceUseCase: di()),
  );

  di.registerFactory<RecintoBloc>(
    () => RecintoBloc(
      getRecintosUseCase: di(),
      createRecintoUseCase: di(),
      updateRecintoUseCase: di(),
      deleteRecintoUseCase: di(),
    ),
  );

  di.registerFactory<HabitacionBloc>(
    () => HabitacionBloc(
      getHabitacionesUseCase: di(),
      createHabitacionUseCase: di(),
      updateHabitacionUseCase: di(),
      deleteHabitacionUseCase: di(),
    ),
  );

  di.registerFactory<TipoHospedajeBloc>(
    () => TipoHospedajeBloc(
      getTipoHospedajesUseCase: di(),
      createTipoHospedajeUseCase: di(),
      updateTipoHospedajeUseCase: di(),
      deleteTipoHospedajeUseCase: di(),
    ),
  );

  di.registerFactory<TipoPrecioBloc>(
    () => TipoPrecioBloc(
      getTipoPreciosUseCase: di(),
      createTipoPrecioUseCase: di(),
      updateTipoPrecioUseCase: di(),
      deleteTipoPrecioUseCase: di(),
    ),
  );
}
