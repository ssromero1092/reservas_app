import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';

class EditTipoHospedajeDialog {
  static void show(BuildContext context, ThemeData theme, TipoHospedaje tipoHospedaje) {
    final descripcionController = TextEditingController(text: tipoHospedaje.descripcion);
    final equipamientoController = TextEditingController(text: tipoHospedaje.equipamiento);

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
              const Text('Editar Tipo de Hospedaje'),
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
                    hintText: 'Ej: 2 personas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: equipamientoController,
                  decoration: InputDecoration(
                    labelText: 'Equipamiento',
                    hintText: 'Ej: Cama 2 plazas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.bed),
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
                if (descripcionController.text.trim().isNotEmpty &&
                    equipamientoController.text.trim().isNotEmpty) {
                  final updatedTipoHospedaje = TipoHospedaje(
                    idTipoHospedaje: tipoHospedaje.idTipoHospedaje,
                    descripcion: descripcionController.text.trim(),
                    equipamiento: equipamientoController.text.trim(),
                  );
                  context.read<TipoHospedajeBloc>().add(UpdateTipoHospedaje(updatedTipoHospedaje));
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