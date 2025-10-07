import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/presentation/blocs/cliente/cliente_bloc.dart';
import 'package:reservas_app/features/presentation/pages/widgets/rut_formatter.dart';

class CreateClienteDialog {
  static void show(BuildContext context, ThemeData theme) {
    final nombreCompletoController = TextEditingController();
    final rutController = TextEditingController();
    final telefonoController = TextEditingController();
    final emailController = TextEditingController();

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
              const Text('Nuevo Cliente'),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nombreCompletoController,
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                      hintText: 'Ej: Juan Pérez García',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: rutController,
                    decoration: InputDecoration(
                      labelText: 'RUT',
                      hintText: 'Ej: 12345678-9',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.badge),
                    ),
                    inputFormatters: [RutFormatter()],
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: telefonoController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      hintText: 'Ej: +56 9 1234 5678',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Ej: cliente@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                if (nombreCompletoController.text.trim().isNotEmpty && 
                    rutController.text.trim().isNotEmpty &&
                    telefonoController.text.trim().isNotEmpty &&
                    emailController.text.trim().isNotEmpty) {
                  final cliente = Cliente(
                    idCliente: 0,
                    nombreCompleto: nombreCompletoController.text.trim(),
                    rut: rutController.text.trim(),
                    telefono: telefonoController.text.trim(),
                    email: emailController.text.trim(),
                  );
                  
                  context.read<ClienteBloc>().add(AddCliente(cliente));
                  Navigator.of(dialogContext).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor complete todos los campos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}