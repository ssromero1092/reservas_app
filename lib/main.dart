import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/core/di/bloc_providers.dart';
import 'package:reservas_app/core/di/service_locator.dart';
import 'package:reservas_app/core/routes/app_routter.dart';
import 'package:reservas_app/core/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar dependencias
  await init();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      /// Configuración centralizada de todos los BlocProviders de la aplicación.
      /// Los proveedores están definidos en [BlocProviders.providers] para
      /// mejorar la organización y mantenibilidad del código.
      providers: BlocProviders.providers,
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: 'Reservas App',
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
