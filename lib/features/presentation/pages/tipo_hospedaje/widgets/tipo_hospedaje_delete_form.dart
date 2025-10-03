import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';

class DeleteTipoHospedajeDialog{
  static void show(BuildContext context, ThemeData theme, TipoHospedaje tipoHospedaje) {
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
            const Text('Eliminar T. Hospedaje'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar el tipo de hospedaje "${tipoHospedaje.descripcion}"?\n\nEsta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
            ),
          ElevatedButton(
            onPressed: () {
              context.read<TipoHospedajeBloc>().add(DeleteTipoHospedaje(tipoHospedaje.idTipoHospedaje));
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
