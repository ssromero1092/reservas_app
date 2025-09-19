import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _minSplashDuration = Duration(seconds: 2); // Duración mínima del splash
  DateTime? _splashStartTime;
  AuthState? _pendingAuthState;

  @override
  void initState() {
    super.initState();
    _splashStartTime = DateTime.now();
  }

  void _handleAuthStateChange(AuthState state) {
    _pendingAuthState = state;
    
    final elapsedTime = DateTime.now().difference(_splashStartTime!);
    final remainingTime = _minSplashDuration - elapsedTime;

    if (remainingTime > Duration.zero) {
      // Si no ha pasado el tiempo mínimo, esperamos
      Future.delayed(remainingTime, () {
        _navigateToNextScreen();
      });
    } else {
      // Si ya pasó el tiempo mínimo, navegamos inmediatamente
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    if (!mounted || _pendingAuthState == null) return;

    if (_pendingAuthState is AuthAuthenticated) {
      context.go('/home');
    } else if (_pendingAuthState is AuthUnauthenticated) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            _handleAuthStateChange(state);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.hotel_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Sistema de Reservas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Cargando...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 32),
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}