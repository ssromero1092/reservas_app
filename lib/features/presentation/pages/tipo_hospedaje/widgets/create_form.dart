import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';

class CreateTipoHospedajeDialog {
  static void show(BuildContext context, ThemeData theme) {
    final descripcionController = TextEditingController();
    final equipamientoController = TextEditingController();

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
              const Text('Nuevo T. Hospedaje'),
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
                  final tipoHospedaje = TipoHospedaje(
                    idTipoHospedaje: 0, // Se asignará en el servidor
                    descripcion: descripcionController.text.trim(),
                    equipamiento: equipamientoController.text.trim(),
                  );
                  context.read<TipoHospedajeBloc>().add(AddTipoHospedaje(tipoHospedaje));
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