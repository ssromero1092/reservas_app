import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/features/presentation/pages/habitaciones/habitacion_page.dart';
import 'package:reservas_app/features/presentation/pages/home/home_page.dart';
import 'package:reservas_app/features/presentation/pages/login/login_page.dart';
import 'package:reservas_app/features/presentation/pages/recintos/recinto_page.dart';
import 'package:reservas_app/features/presentation/pages/reservas/reservas_page.dart';
import 'package:reservas_app/features/presentation/pages/splash/splash_page.dart';
import 'package:reservas_app/features/presentation/pages/tipo_hospedaje/tipo_hospedaje_page.dart';
import 'package:reservas_app/features/presentation/pages/tipo_precio/tipo_precio_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: '/', // Cambiar a splash
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        }
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        }
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return const HomePage();
        }
      ),
      GoRoute(
        path: '/reservas',
        name: 'reservas',
        builder: (context, state) {
          return const ReservasPage();
        }
      ),
      GoRoute(
        path: '/recintos',
        name: 'recintos',
        builder: (context, state) {
          return const RecintoPage();
        } 
      ),
      GoRoute(
        path: '/habitaciones',
        name: 'habitaciones',
        builder: (context, state) {
          return const HabitacionPage();
        } 
      ),
      GoRoute(
        path: '/tipos-hospedaje',
        name: 'tipos-hospedaje',
        builder: (context, state) {
          return const TipoHospedajePage();
        } 
      ),
      GoRoute(
        path: '/tipos-precio',
        name: 'tipos-precio',
        builder: (context, state) {
          return const TipoPrecioPage();
        }
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}


