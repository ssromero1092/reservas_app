import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';

class CreateRecintoDialog {
  static void show(BuildContext context, ThemeData theme) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        title: Row(
          children: [
            Icon(Icons.add_business, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Nuevo Recinto'),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Descripción del recinto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.description),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
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
                final recinto = Recinto(
                  idRecinto: 0, // Se asignará en el servidor
                  descripcion: controller.text.trim(),
                );
                context.read<RecintoBloc>().add(AddRecinto(recinto));
                Navigator.of(dialogContext).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
            ),
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}
