import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reservas_app/core/di/service_locator.dart';
import 'package:reservas_app/core/routes/app_routter.dart';
import 'package:reservas_app/core/theme/app_theme.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/login/login_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/reservas/reservas_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar dependencias
  await init();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.instance.get<AuthBloc>()
            ..add(AuthCheckRequested()), // Verificar autenticación al iniciar
        ),
        BlocProvider<LoginBloc>(
          create: (context) => GetIt.instance.get<LoginBloc>(),
        ),
        BlocProvider<ReservasBloc>(
          create: (context) => GetIt.instance.get<ReservasBloc>(),
        ),
        BlocProvider<RecintoBloc>(
          create: (context) => GetIt.instance.get<RecintoBloc>(),
        ),
        BlocProvider<HabitacionBloc>(
          create: (context) => GetIt.instance.get<HabitacionBloc>(),
        ),
        BlocProvider<TipoHospedajeBloc>(
          create: (context) => GetIt.instance.get<TipoHospedajeBloc>(),
        ),
        BlocProvider<TipoPrecioBloc>(
          create: (context) => GetIt.instance.get<TipoPrecioBloc>(),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: 'Reservas App',
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
