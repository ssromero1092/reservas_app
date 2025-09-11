import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/features/presentation/pages/home/home_page.dart';
import 'package:reservas_app/features/presentation/pages/login/login_page.dart';
import 'package:reservas_app/features/presentation/pages/reservas/reservas_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: '/login',
    routes: [
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
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}


