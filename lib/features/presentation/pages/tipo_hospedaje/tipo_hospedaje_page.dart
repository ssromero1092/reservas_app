import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reservas_app/core/constants/k_padding.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';
import 'package:reservas_app/features/presentation/pages/tipo_hospedaje/widgets/create_form.dart';
import 'package:reservas_app/features/presentation/pages/tipo_hospedaje/widgets/delete_form.dart';
import 'package:reservas_app/features/presentation/pages/tipo_hospedaje/widgets/edit_form.dart';
import 'package:toastification/toastification.dart';

class TipoHospedajePage extends StatelessWidget {
  const TipoHospedajePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.hotel,
                color: Colors.white,
                size: 24,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Gestión de Tipos de Hospedaje',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: theme.colorScheme.primary.withOpacity(0.3),
        toolbarHeight: 70,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/home'),
              tooltip: 'Volver al Inicio',
              iconSize: 24,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: KPadding.allMD,
            child: BlocConsumer<TipoHospedajeBloc, TipoHospedajeState>(
              listener: (context, state) {
                if (state is TipoHospedajeSuccess) {
                  toastification.show(
                    context: context,
                    title: const Text('¡Éxito!'),
                    description: Text(state.message),
                    type: ToastificationType.success,
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                } else if (state is TipoHospedajeError) {
                  toastification.show(
                    context: context,
                    title: const Text('Error'),
                    description: Text(state.message),
                    type: ToastificationType.error,
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<TipoHospedajeBloc>().add(const LoadTipoHospedajes());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Cargar'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => CreateTipoHospedajeDialog.show(context, theme),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Nuevo'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _buildContent(context, state, theme),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TipoHospedajeState state, ThemeData theme) {
    if (state is TipoHospedajeLoading) {
      return _buildLoadingState(theme);
    } else if (state is TipoHospedajeLoaded) {
      return _buildLoadedState(state, theme, context);
    } else if (state is TipoHospedajeError) {
      return _buildErrorState(state, theme, context);
    } else {
      return _buildInitialState(theme, context);
    }
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Card(
      elevation: 4,
      child: Container(
        padding: KPadding.allMD,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(
                color: theme.colorScheme.primary,
                size: 50,
              ),
              const SizedBox(height: 24),
              Text(
                'Cargando tipos de hospedaje...',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedState(TipoHospedajeLoaded state, ThemeData theme, BuildContext context) {
    if (state.tipoHospedajes.isEmpty) {
      return Card(
        elevation: 4,
        child: Container(
          padding: KPadding.allMD,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hotel_outlined,
                  size: 80,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay tipos de hospedaje registrados',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea tu primer tipo de hospedaje usando el botón "Nuevo"',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: KPadding.allMD,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tipos de Hospedaje Cargados (${state.tipoHospedajes.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: KPadding.allMD,
              itemCount: state.tipoHospedajes.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final tipoHospedaje = state.tipoHospedajes[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      '${tipoHospedaje.idTipoHospedaje}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    tipoHospedaje.descripcion,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${tipoHospedaje.idTipoHospedaje}'),
                      Text('Equipamiento: ${tipoHospedaje.equipamiento}'),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue[600],
                        ),
                        onPressed: () => EditTipoHospedajeDialog.show(context, theme, tipoHospedaje),
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[600],
                        ),
                        onPressed: () => DeleteTipoHospedajeDialog.show(context, theme, tipoHospedaje),
                        tooltip: 'Eliminar',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(TipoHospedajeError state, ThemeData theme, BuildContext context) {
    return Card(
      elevation: 4,
      color: theme.colorScheme.errorContainer,
      child: Container(
        padding: KPadding.allMD,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar tipos de hospedaje',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TipoHospedajeBloc>().add(const LoadTipoHospedajes());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState(ThemeData theme, BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: KPadding.allMD,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hotel,
                size: 80,
                color: theme.colorScheme.primary.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'Bienvenido a T. Hospedaje',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Toca "Cargar" para comenzar',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TipoHospedajeBloc>().add(const LoadTipoHospedajes());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Comenzar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
