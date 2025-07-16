import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:lh_notificacion_app/core/network/dio_client.dart';
import 'package:lh_notificacion_app/core/storage/secure_storage_repository.dart';
import 'package:lh_notificacion_app/core/storage/shared_preferences_repositoy.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/arranque_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/avatar_local_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/cuenta_corriente_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/empresa_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/notificacion_boleta_remote_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/notificacion_pago_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/periodo_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/datasources/produccion_consumo_remote_data_source.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/arranque_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/avatar_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/cuenta_corriente_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/empresa_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/notificacion_boleta_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/notificacion_pago_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/periodo_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/data/repositories/produccion_consumo_repository_impl.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/arranque_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/avatar_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/cuenta_corriente_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/empresa_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/notificacion_boleta_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/notificacion_pago_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/periodo_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/repositories/produccion_consumo_repository.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/arranque/get_arranque_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/avatar/get_avatar_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/avatar/init_avatar_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/avatar/save_avatar_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/cuenta_corriente/get_cuenta_corriente_by_periodo_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/cuenta_corriente/get_cuenta_corriente_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/empresa/get_empresa_cached_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/empresa/get_empresa_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/login/check_if_user_is_logged_in_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/login/get_cached_user_credentials_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/login/login_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/login/logout_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/notificacion_boleta/get_notificacion_boleta_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/notificacion_boleta/get_pdf_boleta_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/notificacion_pago/get_pago_pdf_boleta_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/notificacion_pago/get_pago_pdf_tiket_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/periodo/get_periodo_and_proceso_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/periodo/get_periodo_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/produccion_consumo/get_produccion_consumo_use_case.dart';
import 'package:lh_notificacion_app/features/auth/domain/usecases/socio/get_socio_use_case.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/Login_form/login_form_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/avatar/avatar_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/boleta/boleta_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/consumo/consumo_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/home/home_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/pago/pago_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/password_form/password_form_bloc.dart';
import 'package:lh_notificacion_app/features/auth/presentation/blocs/simon/simon_bloc.dart';
import 'package:logger/logger.dart';

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

  //Datasource
  di.registerLazySingleton<EmpresaRemoteDataSource>(
    () => EmpresaRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<AvatarLocalDataSource>(
    () => AvatarLocalDataSourceImpl(),
  );
  di.registerLazySingleton<ArranqueRemoteDataSource>(
    () => ArranqueRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<PeriodoRemoteDataSource>(
    () => PeriodoRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<ProduccionConsumoRemoteDataSource>(
    () => ProduccionConsumoRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<NotificacionBoletaRemoteSource>(
    () => NotificacionBoletaRemoteSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<CuentaCorrienteRemoteDataSource>(
    () => CuentaCorrienteRemoteDataSourceImpl(dioClient: di()),
  );
  di.registerLazySingleton<NotificacionPagoRemoteSource>(
    () => NotificacionPagoRemoteSourceImpl(dioClient: di()),
  );

  //Repositories
  di.registerLazySingleton<EmpresaRepository>(
    () => EmpresaRepositoryImpl(empresaRemoteDataSource: di()),
  );
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: di(),
      secureStorage: di(),
      sharedRepository: di(),
    ),
  );
  di.registerLazySingleton<AvatarRepository>(
    () => AvatarRepositoryImpl(
      avatarLocalDataSource: di(),
      sharedRepository: di(),
    ),
  );
  di.registerLazySingleton<ArranqueRepository>(
    () => ArranqueRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<PeriodoRepository>(
    () => PeriodoRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<ProduccionConsumoRepository>(
    () => ProduccionConsumoRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<NotificacionBoletaRepository>(
    () => NotificacionBoletaRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<CuentaCorrienteRepository>(
    () => CuentaCorrienteRepositoryImpl(remoteDataSource: di()),
  );
  di.registerLazySingleton<NotificacionPagoRepository>(
    () => NotificacionPagoRepositoryImpl(remoteDataSource: di()),
  );

  //Use Cases
  di.registerLazySingleton<GetEmpresaUseCase>(
    () => GetEmpresaUseCase(empresaRepository: di()),
  );
  di.registerLazySingleton<CheckIfUserIsLoggedInUseCase>(
    () => CheckIfUserIsLoggedInUseCase(repository: di()),
  );
  di.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: di()),
  );
  di.registerLazySingleton<GetCachedUserCredentialsUseCase>(
    () => GetCachedUserCredentialsUseCase(
      secureStorage: di(),
      sharedRepository: di(),
    ),
  );
  di.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(secureStorage: di(), sharedRepository: di()),
  );
  di.registerLazySingleton<GetAvatarUseCase>(
    () => GetAvatarUseCase(avatarRepository: di()),
  );
  di.registerLazySingleton<InitAvatarUseCase>(
    () => InitAvatarUseCase(avatarRepository: di()),
  );
  di.registerLazySingleton<SaveAvatarUseCase>(
    () => SaveAvatarUseCase(avatarRepository: di()),
  );
  di.registerLazySingleton<GetCachedEmpresaUseCase>(
    () => GetCachedEmpresaUseCase(sharedRepository: di()),
  );
  di.registerLazySingleton<GetArranqueUseCase>(
    () => GetArranqueUseCase(arranqueRepository: di()),
  );
  di.registerLazySingleton<GetSocioUseCase>(
    () => GetSocioUseCase(sharedRepository: di()),
  );
  di.registerLazySingleton<GetPeriodoAndProcesoUseCase>(
    () => GetPeriodoAndProcesoUseCase(periodoRepository: di()),
  );
  di.registerLazySingleton<GetProduccionConsumoUseCase>(
    () => GetProduccionConsumoUseCase(produccionConsumoRepository: di()),
  );
  di.registerLazySingleton<GetNotificacionBoletaUseCase>(
    () => GetNotificacionBoletaUseCase(notificacionBoletaRepository: di()),
  );
  di.registerLazySingleton<GetPdfBoletaUseCase>(
    () => GetPdfBoletaUseCase(notificacionBoletaRepository: di()),
  );
  di.registerLazySingleton<GetCuentaCorrienteUseCase>(
    () => GetCuentaCorrienteUseCase(cuentaCorrienteRepository: di()),
  );
  di.registerLazySingleton<GetCuentaCorrienteByPeriodoUseCase>(
    () => GetCuentaCorrienteByPeriodoUseCase(
      cuentaCorrienteRepository: di(),
      periodoRepository: di(),
    ),
  );
  di.registerLazySingleton<GetPagoPdfBoletaUseCase>(
    () => GetPagoPdfBoletaUseCase(notificacionPagoRepository: di()),
  );
  di.registerLazySingleton<GetPagoPdfTiketUseCase>(
    () => GetPagoPdfTiketUseCase(notificacionPagoRepository: di()),
  );
  di.registerLazySingleton<GetPeriodoUseCase>(
    () => GetPeriodoUseCase(periodoRepository: di()),
  );

  //BLOC
  di.registerFactory<AuthBloc>(
    () => AuthBloc(
      getEmpresaUseCase: di(),
      checkIfUserIsLoggedInUsecase: di(),
      loginUseCase: di(),
      getCachedUserCredentialsUseCase: di(),
      logoutUseCase: di(),
      getCachedEmpresaUseCase: di(),
      getArranqueUseCase: di(),
      getSocioUseCase: di(),
      getCuentaCorrienteByPeriodoUseCase: di(),
    ),
  );
  di.registerFactory<LoginFormBloc>(() => LoginFormBloc(loginUseCase: di()));
  di.registerFactory<PasswordFormBloc>(() => PasswordFormBloc());
  di.registerFactory<AvatarBloc>(
    () => AvatarBloc(
      getAvatarUseCase: di(),
      initAvatarUseCase: di(),
      saveAvatarUseCase: di(),
    ),
  );
  di.registerFactory<ConsumoBloc>(
    () => ConsumoBloc(getProduccionConsumoUseCase: di(), getSocioUseCase: di()),
  );
  di.registerFactory<BoletaBloc>(
    () => BoletaBloc(
      getPeriodoAndProcesoUseCase: di(),
      getSocioUseCase: di(),
      getNotificacionBoletaUseCase: di(),
      getPdfBoletaUseCase: di(),
      getCachedEmpresaUseCase: di(),
    ),
  );
  di.registerFactory<PagoBloc>(
    () => PagoBloc(
      getPeriodoAndProcesoUseCase: di(),
      getSocioUseCase: di(),
      getArranqueUseCase: di(),
      getCuentaCorrienteUseCase: di(),
      getPagoPdfBoletaUseCase: di(),
      getCachedEmpresaUseCase: di(),
      getPagoPdfTiketUseCase: di(),
    ),
  );
  di.registerFactory<HomeBloc>(() => HomeBloc());
  di.registerFactory<SimonBloc>(() => SimonBloc(getPeriodoUseCase: di()));
}
