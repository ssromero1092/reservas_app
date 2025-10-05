import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;
  final String buttonText;
  final VoidCallback onRetry;
  
  final Color? backgroundColor;
  final Color? iconColor;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.title = 'Error al cargar los datos',
    this.icon = Icons.error_outline,
    this.buttonText = 'Reintentar',
    this.backgroundColor,
    this.iconColor,
  });
  /// Factory constructor específico para errores de carga de recintos
  factory ErrorStateWidget.recintos({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      message: message,
      title: 'Error al cargar los recintos',
      onRetry: onRetry,
    );
  }

  /// Factory constructor específico para errores de carga de habitaciones
  factory ErrorStateWidget.habitaciones({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      message: message,
      title: 'Error al cargar las habitaciones',
      onRetry: onRetry,
    );
  }

  /// Factory constructor específico para errores de carga de tipos de hospedaje
  factory ErrorStateWidget.tiposHospedaje({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      message: message,
      title: 'Error al cargar tipos de hospedaje',
      onRetry: onRetry,
    );
  }

  /// Factory constructor específico para errores de carga de tipos de precio
  factory ErrorStateWidget.tiposPrecios({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      message: message,
      title: 'Error al cargar tipos de precio',
      onRetry: onRetry,
    );
  }

  /// Factory constructor específico para errores de carga de listas de precio
  factory ErrorStateWidget.listaPrecios({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      message: message,
      title: 'Error al cargar las listas de precio',
      onRetry: onRetry,
    );
  }

  /// Factory constructor específico para errores de carga de servicios
  factory ErrorStateWidget.servicios({
    required String message,
    required VoidCallback onRetry,
  }) {
    return ErrorStateWidget(
      title: 'Error al Cargar Servicios',
      message: message,
      icon: Icons.room_service_outlined,
      buttonText: 'Reintentar',
      onRetry: onRetry,
      backgroundColor: Colors.red[50],
      iconColor: Colors.red[400],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      color: backgroundColor ?? theme.colorScheme.errorContainer,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: iconColor ?? theme.colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(buttonText),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}