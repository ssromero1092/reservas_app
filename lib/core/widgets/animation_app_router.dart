// Importamos las librerías necesarias
import 'dart:math' as math; // Para operaciones matemáticas como seno, coseno, pi
import 'dart:ui' as ui;    // Para efectos visuales avanzados como blur (desenfoque)

import 'package:flutter/material.dart'; // Framework de Flutter para UI
import 'package:go_router/go_router.dart'; // Para navegación entre pantallas

/// 🎨 Custom Painter para dibujar el efecto visual del portal interdimensional
/// CustomPainter nos permite dibujar formas personalizadas en el canvas
class PortalPainter extends CustomPainter {
  // Variables que controlan cómo se ve el portal
  final double progress; // Progreso de la animación (0.0 a 1.0)
  final double radius;   // Radio del círculo del portal
  final Color color;     // Color base del portal

  const PortalPainter({
    required this.progress,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Si no hay progreso, no dibujamos nada
    if (progress <= 0) return;

    // Calculamos el centro de la pantalla
    final center = Offset(size.width / 2, size.height / 2);
    
    // Configuramos el pincel con un gradiente radial (del centro hacia afuera)
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.8 * progress), // Centro más opaco
          color.withOpacity(0.3 * progress), // Intermedio menos opaco
          Colors.transparent,                // Borde transparente
        ],
        stops: const [0.0, 0.7, 1.0], // Dónde cambian los colores
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Dibujamos el círculo del portal
    canvas.drawCircle(center, radius * progress, paint);
  }

  @override
  bool shouldRepaint(covariant PortalPainter oldDelegate) {
    // Solo redibujamos si alguna propiedad cambió
    return progress != oldDelegate.progress ||
        radius != oldDelegate.radius ||
        color != oldDelegate.color;
  }
}

/// ✂️ Custom Clipper para crear el efecto de recorte circular del portal
/// CustomClipper nos permite "recortar" widgets en formas específicas
class PortalClipper extends CustomClipper<Path> {
  final double progress; // Progreso de la animación

  const PortalClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path(); // Creamos un camino (forma) para recortar
    
    // Si no hay progreso, devolvemos un camino vacío (no se ve nada)
    if (progress <= 0) {
      return path;
    }
    
    // Calculamos el centro y radio del círculo de recorte
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.max(size.width, size.height) * progress;
    
    // Creamos un óvalo (círculo) que crece con el progreso
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(covariant PortalClipper oldClipper) {
    // Solo re-recortamos si el progreso cambió
    return progress != oldClipper.progress;
  }
}

/// 🚀 Clase principal que contiene todas las animaciones de transición
/// Esta clase define diferentes tipos de transiciones entre pantallas
class AppAnimationTransitions {
  
  /// Transición innovadora: "Morphing Portal Transition"
  /// Esta es la transición más compleja y visualmente impactante
  /// 
  /// Efectos que incluye:
  /// - Portal circular que se expande con gradiente radial
  /// - Partículas que orbitan alrededor del centro con colores cambiantes
  /// - Rotación 3D con perspectiva para dar profundidad
  /// - Efecto de desenfoque progresivo (blur)
  /// - Efecto de "respiración" sutil (pulsación ligera)
  /// - Sombras dinámicas que cambian de color
  static Page<dynamic> morphingPortalTransition(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,        // Identificador único de la página
      child: child,              // El widget de la nueva pantalla
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Aquí construimos la animación personalizada
        return _buildMorphingPortalAnimation(context, animation, child);
      },
      transitionDuration: const Duration(milliseconds: 800),        // Duración hacia adelante
      reverseTransitionDuration: const Duration(milliseconds: 600), // Duración hacia atrás
    );
  }

  /// Transición clásica: Fade Transition
  /// Hace que la nueva pantalla aparezca gradualmente (se desvanece hacia adentro)
  static Page<dynamic> fadeTransition(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation, // La opacidad va de 0 (invisible) a 1 (visible)
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300), // Transición rápida y sutil
    );
  }

  /// Transición de escala
  /// La nueva pantalla aparece creciendo desde el centro
  static Page<dynamic> scaleTransition(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation, // La escala va de 0 (punto) a 1 (tamaño normal)
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Transición de deslizamiento
  /// La nueva pantalla se desliza desde la derecha hacia la izquierda
  static Page<dynamic> slideTransition(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Configuramos el movimiento
        const begin = Offset(1.0, 0.0); // Comienza fuera de la pantalla (derecha)
        const end = Offset.zero;         // Termina en posición normal
        const curve = Curves.easeInOut;  // Curva suave de aceleración

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  /// 🎨 Construcción de la animación Morphing Portal (la más compleja)
  /// Esta función combina múltiples efectos para crear una transición espectacular
  static Widget _buildMorphingPortalAnimation(
    BuildContext context, 
    Animation<double> animation, 
    Widget? child,
  ) {
    // Creamos diferentes curvas de animación para cada efecto
    // Cada curva controla la velocidad y aceleración de un aspecto específico
    
    final portalCurve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic, // Suave al inicio y final, rápido en el medio
    );
    
    final blurCurve = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn, // Rápido al salir, lento al entrar
    );
    
    final colorCurve = CurvedAnimation(
      parent: animation,
      curve: Curves.bounceInOut, // Con rebote para el cambio de color
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Portal circular que se expande desde el centro
        final portalRadius = Tween<double>(
          begin: 0.0,
          end: MediaQuery.of(context).size.width * 2, // Crece hasta ser muy grande
        ).animate(portalCurve).value;

        // Rotación 3D en el eje X para dar efecto de profundidad
        final rotationX = Tween<double>(
          begin: math.pi / 2, // Empieza rotado 90 grados (invisible de lado)
          end: 0.0,           // Termina sin rotación (de frente)
        ).animate(portalCurve).value;

        // Color que cambia dinámicamente durante la animación
        final hue = Tween<double>(
          begin: 240, // Azul inicial
          end: 200,   // Azul más vivo/cian
        ).animate(colorCurve).value;

        // Efecto de desenfoque que disminuye gradualmente
        final blurAmount = Tween<double>(
          begin: 10.0, // Muy desenfocado al inicio
          end: 0.0,    // Nítido al final
        ).animate(blurCurve).value;

        // Efecto de "respiración" sutil usando seno para crear pulsación
        final breathScale = 1.0 + (math.sin(animation.value * math.pi * 4) * 0.02);
        final mainScale = Tween<double>(
          begin: 0.7, // Comienza más pequeño
          end: 1.0,   // Termina en tamaño normal
        ).animate(portalCurve).value;

        return Stack(
          children: [
            // Partículas que orbitan alrededor del centro
            ..._buildOrbitalParticles(context, animation, hue),
            
            // Portal circular de fondo con gradiente
            _buildPortalBackground(animation, portalRadius, hue),
            
            // Contenido principal con todos los efectos combinados
            _buildMainContent(
              context, 
              animation, 
              child, 
              rotationX,    // Rotación 3D
              mainScale,    // Escala principal
              breathScale,  // Efecto respiración
              blurAmount,   // Cantidad de desenfoque
              hue,          // Color actual
            ),
          ],
        );
      },
      child: child,
    );
  }

  /// 🌌 Construcción de partículas que orbitan alrededor del centro
  /// Estas partículas crean un efecto visual de "energía" alrededor del portal
  static List<Widget> _buildOrbitalParticles(
    BuildContext context, 
    Animation<double> animation, 
    double hue,
  ) {
    // Generamos 12 partículas distribuidas en círculo
    return List.generate(12, (index) {
      // Calculamos el ángulo de cada partícula (360° dividido entre 12 = 30° cada una)
      final angle = (index / 12) * 2 * math.pi;
      
      // La distancia desde el centro aumenta con la animación
      final distance = 100 + (animation.value * 200);
      
      // Calculamos las coordenadas X e Y usando trigonometría
      // Agregamos rotación constante para que las partículas "orbiten"
      final x = math.cos(angle + animation.value * math.pi) * distance;
      final y = math.sin(angle + animation.value * math.pi) * distance;
      
      return Positioned(
        // Posicionamos cada partícula relativa al centro de la pantalla
        left: MediaQuery.of(context).size.width / 2 + x,
        top: MediaQuery.of(context).size.height / 2 + y,
        child: Container(
          width: 5,  // Partículas pequeñas
          height: 5,
          decoration: BoxDecoration(
            // Cada partícula tiene un color diferente basado en su posición
            color: HSVColor.fromAHSV(
              1.0 - animation.value,           // Opacidad que disminuye
              (hue + (index * 30)) % 360,      // Color diferente para cada partícula
              1.0,                             // Saturación máxima
              1.0,                             // Brillo máximo
            ).toColor(),
            shape: BoxShape.circle,            // Forma circular
            boxShadow: [
              BoxShadow(
                // Sombra que hace brillar cada partícula
                color: HSVColor.fromAHSV(
                  0.5,
                  (hue + (index * 30)) % 360,
                  1.0,
                  1.0,
                ).toColor(),
                blurRadius: 4,    // Radio de difuminado de la sombra
                spreadRadius: 1,  // Extensión de la sombra
              ),
            ],
          ),
        ),
      );
    });
  }

  /// 🌀 Construcción del fondo del portal
  /// Este es el círculo grande con gradiente que aparece detrás de todo
  static Widget _buildPortalBackground(
    Animation<double> animation, 
    double portalRadius, 
    double hue,
  ) {
    return Positioned.fill( // Ocupa toda la pantalla
      child: CustomPaint(
        painter: PortalPainter(
          progress: animation.value,                                    // Progreso actual
          radius: portalRadius,                                         // Radio calculado
          color: HSVColor.fromAHSV(1.0, hue % 360, 0.8, 0.9).toColor(), // Color actual
        ),
      ),
    );
  }

  /// 🎭 Construcción del contenido principal con efectos
  static Widget _buildMainContent(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
    double rotationX,
    double mainScale,
    double breathScale,
    double blurAmount,
    double hue,
  ) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Perspectiva 3D
        ..rotateX(rotationX)
        ..scale(mainScale * breathScale),
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: HSVColor.fromAHSV(
                  0.1 * animation.value,
                  hue % 10,
                  1.0,
                  1.0,
                ).toColor(),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipPath(
            clipper: PortalClipper(animation.value),
            child: child,
          ),
        ),
      ),
    );
  }
}