import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/presentation/blocs/cliente/cliente_bloc.dart';

class DeleteClienteDialog {
  static void show(BuildContext context, ThemeData theme, Cliente cliente) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.all(24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        title: Row(
          children: [
            Icon(Icons.delete_forever, color: Colors.red[600]),
            const SizedBox(width: 8),
            const Text('Eliminar Cliente'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Estás seguro de que deseas eliminar este cliente?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: ${cliente.nombreCompleto}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('RUT: ${cliente.rut}'),
                  const SizedBox(height: 4),
                  Text('Teléfono: ${cliente.telefono}'),
                  const SizedBox(height: 4),
                  Text('Email: ${cliente.email}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Esta acción no se puede deshacer.',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ClienteBloc>().add(DeleteCliente(cliente.idCliente));
              Navigator.of(dialogContext).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}