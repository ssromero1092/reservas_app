import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:reservas_app/features/presentation/widgets/animations/splash_animation_widget.dart';

/// Página de splash que maneja la lógica de navegación
/// mientras usa el widget de animación reutilizable
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _minSplashDuration = Duration(seconds: 2);
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
      Future.delayed(remainingTime, () {
        _navigateToNextScreen();
      });
    } else {
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

  void _onAnimationComplete() {
    // Opcional: realizar alguna acción cuando la animación termina
    // Por ejemplo, forzar la navegación si ya pasó el tiempo mínimo
    if (_pendingAuthState != null) {
      final elapsedTime = DateTime.now().difference(_splashStartTime!);
      if (elapsedTime >= _minSplashDuration) {
        _navigateToNextScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          _handleAuthStateChange(state);
        },
        child: SplashAnimationWidget(
          title: 'Sistema de Reservas',
          subtitle: 'Gestión Hotelera Profesional',
          icon: Icons.hotel_rounded,
          iconSize: 90,
          loadingMessage: 'Inicializando sistema...',
          showLoading: true,
          animationDuration: const Duration(milliseconds: 2200),
          onAnimationComplete: _onAnimationComplete,
        ),
      ),
    );
  }
}