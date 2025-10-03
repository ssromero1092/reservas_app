import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Widget de animación reutilizable para el splash screen
/// Contiene todas las animaciones sin la lógica de navegación
class SplashAnimationWidget extends StatefulWidget {
  /// Título principal a mostrar
  final String title;
  
  /// Subtítulo a mostrar
  final String subtitle;
  
  /// Icono principal a mostrar
  final IconData icon;
  
  /// Tamaño del icono
  final double iconSize;
  
  /// Mensaje de carga
  final String loadingMessage;
  
  /// Si debe mostrar el indicador de carga
  final bool showLoading;
  
  /// Duración total de la animación
  final Duration animationDuration;
  
  /// Callback cuando la animación principal termina
  final VoidCallback? onAnimationComplete;

  const SplashAnimationWidget({
    super.key,
    this.title = 'Sistema de Reservas',
    this.subtitle = 'Gestión Hotelera Profesional',
    this.icon = Icons.hotel_rounded,
    this.iconSize = 90,
    this.loadingMessage = 'Inicializando sistema...',
    this.showLoading = true,
    this.animationDuration = const Duration(milliseconds: 2200),
    this.onAnimationComplete,
  });

  @override
  State<SplashAnimationWidget> createState() => _SplashAnimationWidgetState();
}

class _SplashAnimationWidgetState extends State<SplashAnimationWidget>
    with TickerProviderStateMixin {
  
  // 🎬 Controladores de animación ultra-optimizados
  late AnimationController _masterController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particlesController;
  late AnimationController _waveController;
  late AnimationController _glowController;

  // 🎨 Animaciones principales
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;
  late Animation<double> _logoGlow;

  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<Offset> _subtitleSlide;

  late Animation<double> _backgroundOpacity;
  late Animation<double> _glowIntensity;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // ⚡ Controladores ultra-optimizados
    _masterController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _particlesController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // 🌟 Animaciones con curves ultra-naturales
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const ElasticOutCurve(0.8),
    ));

    _logoRotation = Tween<double>(
      begin: -math.pi * 0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInQuart),
    ));

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutCubic,
    ));

    _logoGlow = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
    ));

    // ✨ Animaciones de texto más fluidas
    _titleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInQuart),
    ));

    _titleSlide = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutQuart,
    ));

    _subtitleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeInQuart),
    ));

    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutQuart,
    ));

    // 🌊 Animaciones de ambiente
    _backgroundOpacity = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: Curves.easeInOutQuart,
    ));

    _glowIntensity = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOutSine,
    ));
  }

  void _startAnimationSequence() async {
    // 🚀 Secuencia ultra-fluida
    _masterController.forward();
    _waveController.repeat();
    _glowController.repeat(reverse: true);
    
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    _particlesController.repeat();

    // Notificar cuando la animación principal termina
    _masterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _masterController.dispose();
    _logoController.dispose();
    _textController.dispose();
    _particlesController.dispose();
    _waveController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _masterController,
        _logoController,
        _textController,
        _particlesController,
        _waveController,
        _glowController,
      ]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withOpacity(_backgroundOpacity.value * 0.9),
                theme.colorScheme.primary.withOpacity(_backgroundOpacity.value * 0.7),
                theme.colorScheme.secondary.withOpacity(_backgroundOpacity.value * 0.5),
                theme.colorScheme.tertiary.withOpacity(_backgroundOpacity.value * 0.3),
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // 🌊 Ondas de fondo
              ..._buildAnimatedWaves(size),
              
              // ✨ Partículas flotantes mejoradas
              ..._buildEnhancedParticles(size),

              // 🎭 Contenido principal
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🏨 Logo con efectos avanzados
                    _buildAnimatedLogo(theme),

                    const SizedBox(height: 50),

                    // 📝 Título con efectos mejorados
                    _buildAnimatedTitle(),

                    const SizedBox(height: 20),

                    // 📝 Subtítulo elegante
                    _buildAnimatedSubtitle(),

                    if (widget.showLoading) ...[
                      const SizedBox(height: 60),
                      _buildLoadingIndicator(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedLogo(ThemeData theme) {
    return SlideTransition(
      position: _logoSlide,
      child: FadeTransition(
        opacity: _logoOpacity,
        child: RotationTransition(
          turns: _logoRotation,
          child: ScaleTransition(
            scale: _logoScale,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4 * _logoGlow.value),
                    blurRadius: 30 + (10 * _glowIntensity.value),
                    spreadRadius: 8 + (4 * _glowIntensity.value),
                  ),
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3 * _logoGlow.value),
                    blurRadius: 50 + (15 * _glowIntensity.value),
                    spreadRadius: 12 + (6 * _glowIntensity.value),
                  ),
                ],
              ),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.8),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ).createShader(bounds);
                },
                child: Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return SlideTransition(
      position: _titleSlide,
      child: FadeTransition(
        opacity: _titleOpacity,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.8),
            ],
          ).createShader(bounds),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.5,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return SlideTransition(
      position: _subtitleSlide,
      child: FadeTransition(
        opacity: _subtitleOpacity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.95),
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return FadeTransition(
      opacity: _subtitleOpacity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 45,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.loadingMessage,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // 🌊 Ondas de fondo animadas
  List<Widget> _buildAnimatedWaves(Size size) {
    return List.generate(3, (index) {
      final delay = index * 0.3;
      final waveAnimation = Tween<double>(
        begin: 0.0,
        end: 2 * math.pi,
      ).animate(CurvedAnimation(
        parent: _waveController,
        curve: Interval(delay, 1.0, curve: Curves.linear),
      ));

      return Positioned.fill(
        child: AnimatedBuilder(
          animation: waveAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                waveAnimation.value,
                Colors.white.withOpacity(0.03 + (index * 0.01)),
                index,
              ),
            );
          },
        ),
      );
    });
  }

  // ✨ Partículas flotantes mejoradas
  List<Widget> _buildEnhancedParticles(Size size) {
    final particles = <Widget>[];

    for (int i = 0; i < 20; i++) {
      final delay = (i * 150.0) / 3000.0;
      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _particlesController,
        curve: Interval(
          delay.clamp(0.0, 0.8),
          (delay + 0.7).clamp(0.2, 1.0),
          curve: Curves.easeInOut,
        ),
      ));

      particles.add(
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final progress = animation.value;
            final baseAngle = i * 18.0;
            final angle = baseAngle + (progress * 180);
            final radiusBase = 120 + (i % 3) * 40;
            final radius = radiusBase + (math.sin(progress * math.pi * 3) * 30);

            final x = size.width / 2 + math.cos(angle * math.pi / 180) * radius;
            final y = size.height / 2 + math.sin(angle * math.pi / 180) * radius;

            final opacity = (math.sin(progress * math.pi) * 0.8).clamp(0.0, 1.0);
            final scale = 0.5 + (math.sin(progress * math.pi * 2) * 0.5);

            return Positioned(
              left: x - 6,
              top: y - 6,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(opacity),
                        Colors.white.withOpacity(opacity * 0.5),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return particles;
  }
}

// 🎨 Painter para ondas fluidas
class WavePainter extends CustomPainter {
  final double progress;
  final Color color;
  final int waveIndex;

  WavePainter(this.progress, this.color, this.waveIndex);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 30.0 + (waveIndex * 10);
    final frequency = 0.02 + (waveIndex * 0.005);

    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x += 2) {
      final y = size.height - waveHeight + 
          math.sin((x * frequency) + progress) * waveHeight * 0.5;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}