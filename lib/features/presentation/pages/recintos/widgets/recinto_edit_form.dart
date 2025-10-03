import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';

class EditRecientoDialog {
  static void show(BuildContext context, ThemeData theme, Recinto recinto) {
    final controller = TextEditingController(text: recinto.descripcion);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        title: Row(
          children: [
            Icon(Icons.edit, color: Colors.blue[600]),
            const SizedBox(width: 8),
            const Text('Editar Recinto'),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Descripción del recinto',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.description),
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final updatedRecinto = Recinto(
                  idRecinto: recinto.idRecinto,
                  descripcion: controller.text.trim(),
                );
                context.read<RecintoBloc>().add(UpdateRecinto(updatedRecinto));
                Navigator.of(dialogContext).pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

}
