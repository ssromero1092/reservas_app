import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';

class DeleteHabitacionDialog {
static void show(BuildContext context, ThemeData theme, Habitacion habitacion) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.all(24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        title: Row(
          children: [
            Icon(Icons.delete_forever, color: Colors.red[600]),
            const SizedBox(width: 8),
            const Text('Eliminar Habitación'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar la habitación "${habitacion.descripcion}"?\n\nEsta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HabitacionBloc>().add(DeleteHabitacion(habitacion.idHabitacion));
              Navigator.of(dialogContext).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

}