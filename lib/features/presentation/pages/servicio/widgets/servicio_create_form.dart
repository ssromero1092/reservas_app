import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';
import 'package:reservas_app/features/presentation/blocs/servicio/servicio_bloc.dart';

class CreateServicioDialog {
  static void show(BuildContext context, ThemeData theme) {
    final descripcionController = TextEditingController();
    final valorController = TextEditingController();
    final observacionController = TextEditingController();

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
            const Text('Nuevo Servicio'),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción del servicio',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.room_service),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: valorController,
                  decoration: InputDecoration(
                    labelText: 'Valor referencial',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: observacionController,
                  decoration: InputDecoration(
                    labelText: 'Observación',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.note),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                ),
              ],
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
              if (descripcionController.text.trim().isNotEmpty) {
                final servicio = Servicio(
                  idServicio: 0, // Se asignará en el servidor
                  descripcion: descripcionController.text.trim(),
                  valorReferencial: int.tryParse(valorController.text) ?? 0,
                  observacion: observacionController.text.trim(),
                );
                context.read<ServicioBloc>().add(AddServicio(servicio));
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