import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/core/constants/app_routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.go(AppRoutes.home),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: _isCurrentPath(AppRoutes.home) 
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: _isCurrentPath(AppRoutes.home)
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isCurrentPath(AppRoutes.home) ? Icons.home : Icons.home_rounded,
                    color: _isCurrentPath(AppRoutes.home)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryContainer,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inicio',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isCurrentPath(AppRoutes.home)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryContainer,
                      fontWeight: _isCurrentPath(AppRoutes.home)
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isCurrentPath(String path) {
    return currentPath == path;
  }
}
