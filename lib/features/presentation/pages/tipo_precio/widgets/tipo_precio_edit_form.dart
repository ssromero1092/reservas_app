import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';

class EditTipoPrecioDialog {
  static void show(BuildContext context, ThemeData theme, TipoPrecio tipoPrecio) {
    final descripcionController = TextEditingController(text: tipoPrecio.descripcion);
    final observacionController = TextEditingController(text: tipoPrecio.observacion);

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
              Icon(Icons.edit, color: Colors.blue[600]),
              const SizedBox(width: 8),
              const Text('Editar Tipo de Precio'),
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
                  final updatedTipoPrecio = TipoPrecio(
                    idTipoPrecio: tipoPrecio.idTipoPrecio,
                    descripcion: descripcionController.text.trim(),
                    observacion: observacionController.text.trim(),
                  );
                  context.read<TipoPrecioBloc>().add(UpdateTipoPrecio(updatedTipoPrecio));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
              ),
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}