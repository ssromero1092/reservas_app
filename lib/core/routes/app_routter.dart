import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/core/widgets/animation_app_router.dart';
import 'package:reservas_app/features/presentation/pages/habitaciones/habitacion_page.dart';
import 'package:reservas_app/features/presentation/pages/home/home_page.dart';
import 'package:reservas_app/features/presentation/pages/lista_precio/lista_precio_page.dart';
import 'package:reservas_app/features/presentation/pages/login/login_page.dart';
import 'package:reservas_app/features/presentation/pages/recintos/recinto_page.dart';
import 'package:reservas_app/features/presentation/pages/reservas/reservas_page.dart';
import 'package:reservas_app/features/presentation/pages/servicio/servicio_page.dart';
import 'package:reservas_app/features/presentation/pages/splash/splash_page.dart';
import 'package:reservas_app/features/presentation/pages/tipo_hospedaje/tipo_hospedaje_page.dart';
import 'package:reservas_app/features/presentation/pages/tipo_precio/tipo_precio_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      /*
      original con animacion standard
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        }
      ),
      */
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/reservas',
        name: 'reservas',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const ReservasPage(), state);
        },
      ),
      GoRoute(
        path: '/recintos',
        name: 'recintos',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const RecintoPage(), state);
        },
      ),
      GoRoute(
        path: '/habitaciones',
        name: 'habitaciones',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const HabitacionPage(), state);
        },
      ),
      GoRoute(
        path: '/tipos-hospedaje',
        name: 'tipos-hospedaje',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const TipoHospedajePage(), state);
        },
      ),
      GoRoute(
        path: '/tipos-precio',
        name: 'tipos-precio',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const TipoPrecioPage(), state);
        },
      ),
      GoRoute(
        path: '/servicios',
        name: 'servicios',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const ServicioPage(), state);
        },
      ),
      GoRoute(
        path: '/listas-precio',
        name: 'listas-precio',
        pageBuilder: (context, state) {
          return AppAnimationTransitions.morphingPortalTransition(const ListaPrecioPage(), state);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
}
