import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/features/presentation/pages/widgets/bottom_navigation_bar.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.showBottomNav = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.path;

    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavBar(currentPath: currentPath)
          : null,
    );
  }
}
