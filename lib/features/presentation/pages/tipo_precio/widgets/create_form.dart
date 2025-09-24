import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';

class CreateTipoPrecioDialog {
  static void show(BuildContext context, ThemeData theme) {
    final descripcionController = TextEditingController();
    final observacionController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(24),
          insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
          title: Row(
            children: [
              Icon(Icons.add, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              const Text('Nuevo Tipo Precio'),
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
                      labelText: 'Descripción',
                      hintText: 'Ej: Precio Fin de Semana',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.price_change),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: observacionController,
                    decoration: InputDecoration(
                      labelText: 'Observación',
                      hintText: 'Ej: Aplica sábados y domingos',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.note),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
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
                  final tipoPrecio = TipoPrecio(
                    idTipoPrecio: 0, // Se asignará en el servidor
                    descripcion: descripcionController.text.trim(),
                    observacion: observacionController.text.trim(),
                  );
                  context.read<TipoPrecioBloc>().add(AddTipoPrecio(tipoPrecio));
                  Navigator.of(dialogContext).pop();
                } else {
                  // Mostrar error si faltan campos
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor completa todos los campos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}