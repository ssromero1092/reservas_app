import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';

class EditHabitacionDialog { 
  static void show(BuildContext context, ThemeData theme, Habitacion habitacion) {
    final descriptionController = TextEditingController(text: habitacion.descripcion);
    final capacidadController = TextEditingController(text: habitacion.capacidad);
    int selectedIdRecinto = habitacion.idRecinto;

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
              const Text('Editar Habitación'),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción de la habitación',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: capacidadController,
                  decoration: InputDecoration(
                    labelText: 'Capacidad',
                    hintText: 'Ej: 1, 1+2, 2+1, etc.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.people),
                  ),
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(height: 16),
                BlocBuilder<RecintoBloc, RecintoState>(
                  builder: (context, recintoState) {
                    if (recintoState is RecintoLoaded) {
                      return DropdownButtonFormField<int>(
                        value: selectedIdRecinto,
                        decoration: InputDecoration(
                          labelText: 'Recinto',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.business),
                        ),
                        items: recintoState.recintos.map((recinto) {
                          return DropdownMenuItem(
                            value: recinto.idRecinto,
                            child: SizedBox(
                              child: Text(
                                recinto.descripcion,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIdRecinto = value!;
                          });
                        },
                      );
                    } else {
                      // Cargar recintos si no están cargados
                      context.read<RecintoBloc>().add(const LoadRecintos());
                      return Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 8),
                              Text('Cargando recintos...'),
                            ],
                          ),
                        ),
                      );
                    }
                  },
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
                if (descriptionController.text.trim().isNotEmpty &&
                    capacidadController.text.trim().isNotEmpty) {
                  final updatedHabitacion = Habitacion(
                    idHabitacion: habitacion.idHabitacion,
                    descripcion: descriptionController.text.trim(),
                    capacidad: capacidadController.text.trim(),
                    idRecinto: selectedIdRecinto,
                    recinto: habitacion.recinto,
                  );
                  context.read<HabitacionBloc>().add(UpdateHabitacion(updatedHabitacion));
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
