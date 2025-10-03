import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/presentation/blocs/habitacion/habitacion_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/recinto/recinto_bloc.dart';

class CreateHabitacionDialog {
static void show(BuildContext context, ThemeData theme) {
    final descriptionController = TextEditingController();
    final capacidadController = TextEditingController();
    int? selectedIdRecinto;

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
              const Text('Nueva Habitación'),
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
                          initialValue: selectedIdRecinto,
                          decoration: InputDecoration(
                            labelText: 'Recinto',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.business),
                          ),
                          hint: const Text('Selecciona un recinto'),
                          items: recintoState.recintos.map((recinto) {
                            return DropdownMenuItem(
                              value: recinto.idRecinto,
                              child: SizedBox(// Limitar ancho para evitar overflow
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
                              selectedIdRecinto = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Por favor selecciona un recinto';
                            }
                            return null;
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
                    capacidadController.text.trim().isNotEmpty && 
                    selectedIdRecinto != null) {
                  final habitacion = Habitacion(
                    idHabitacion: 0, // Se asignará en el servidor
                    descripcion: descriptionController.text.trim(),
                    capacidad: capacidadController.text.trim(),
                    idRecinto: selectedIdRecinto!,
                    recinto: null,
                  );
                  context.read<HabitacionBloc>().add(AddHabitacion(habitacion));
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