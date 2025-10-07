import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/cliente/cliente_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/lista_precio/lista_precio_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/login/login_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/reservas/reservas_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/servicio/servicio_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
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
    BlocProvider<ListaPrecioBloc>(
      create: (context) => GetIt.instance.get<ListaPrecioBloc>(),
    ),
    BlocProvider<ServicioBloc>(
      create: (context) => GetIt.instance.get<ServicioBloc>(),
    ),
    BlocProvider<ClienteBloc>(
      create: (context) => GetIt.instance.get<ClienteBloc>(),
    ),
  ];
}