import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reservas_app/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:reservas_app/features/presentation/pages/widgets/base_scaffold.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          // Mostrar mensaje de logout exitoso
          toastification.show(
            context: context,
            title: const Text('Sesión cerrada'),
            description: const Text('Has cerrado sesión exitosamente'),
            type: ToastificationType.info,
            autoCloseDuration: const Duration(seconds: 2),
          );
          
          // Redireccionar al login
          context.go('/login');
          } else if (state is AuthTokenRefreshFailed) {
          // Mostrar mensaje de error al refrescar token
          toastification.show(
            context: context,
            title: const Text('Error de autenticación'),
            description: Text('No se pudo refrescar la sesión: ${state.message}'),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      },
      child: BaseScaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sistema de Reservas',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // Indicador de refresh de token
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthTokenRefreshing) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          toolbarHeight: 70,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  _showLogoutDialog(context);
                },
                tooltip: 'Cerrar sesión',
                iconSize: 24,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[50]!,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header mejorado con animación
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.waving_hand,
                              color: Theme.of(context).colorScheme.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Bienvenido',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.abc,
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.0),
                              size: 24,
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Título de módulos
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Módulos Disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // Grid mejorado
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildModuleCard(
                        context,
                        icon: Icons.calendar_today_rounded,
                        title: 'Reservas',
                        subtitle: 'Gestionar reservas',
                        color: Colors.blue,
                        onTap: () => context.go('/reservas'),
                      ),
                      _buildModuleCard(
                        context,
                        icon: Icons.hotel_rounded,
                        title: 'Alojamiento',
                        subtitle: 'Administrar hoteles',
                        color: Colors.green,
                        onTap: () => context.go('/alojamiento'),
                      ),
                      /*
                      _buildModuleCard(
                        context,
                        icon: Icons.people_rounded,
                        title: 'Recinto',
                        subtitle: 'Gestión de recintos',
                        color: Colors.orange,
                        onTap: () => context.go('/recintos'),
                      ),*/
                    ],
                  ),
                ),
                
                
                // Menú desplegable para maestros
                _buildMasterDropdown(context),



                
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.orange[600],
              ),
              const SizedBox(width: 8),
              const Text('Cerrar Sesión'),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que deseas cerrar sesión?\n\nSe borrarán todos los datos almacenados localmente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMasterDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.settings_rounded,
              color: Colors.blue[600],
              size: 20,
            ),
          ),
          title: Text(
            'Lista maestros',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue[600],
            ),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.only(bottom: 16),
          iconColor: Colors.blue[600],
          collapsedIconColor: Colors.blue[600],
          children: [
            // Contenedor con altura fija y scroll interno
            Container(
              height: 250, // Altura fija para evitar overflow
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildMasterOption(
                      context,
                      icon: Icons.cabin_rounded,
                      title: 'Recintos',
                      subtitle: 'Gestión de Recintos',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/recintos'),
                    ),
                    _buildMasterOption(
                      context,
                      icon: Icons.bed_rounded,
                      title: 'Habitacion',
                      subtitle: 'Gestión de Habitaciones',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/habitaciones'),
                    ),
                    _buildMasterOption(
                      context,
                      icon: Icons.local_dining_rounded,
                      title: 'Tipo Hospedaje',
                      subtitle: 'Gestión de Tipos de Hospedaje',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/tipos-hospedaje'),
                    ),
                    _buildMasterOption(
                      context,
                      icon: Icons.price_change_rounded,
                      title: 'Tipo Precio',
                      subtitle: 'Gestión de Tipos de Precio',
                      color: Colors.blueGrey[600]!,
                      //onTap: () => context.go('/recintos'),
                      onTap: () => context.go('/tipos-precio'),
                    ),
                    _buildMasterOption(
                      context,
                      icon: Icons.list,
                      title: 'Lista Precio',
                      subtitle: 'Gestión de Listas de Precio',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/listas-precio'),
                    ),            
                    _buildMasterOption(
                      context,
                      icon: Icons.room_service_rounded,
                      title: 'Servicio',
                      subtitle: 'Gestión de Servicios',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/categorias'),
                    ),
                    _buildMasterOption(
                      context,
                      icon: Icons.supervised_user_circle_rounded,
                      title: 'Cliente',
                      subtitle: 'Gestión de Clientes',
                      color: Colors.blueGrey[600]!,
                      onTap: () => context.go('/categorias'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMasterOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: color,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 6,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                color.withOpacity(0.02),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}