import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/presentation/blocs/lista_precio/lista_precio_bloc.dart';

class DeleteListaPrecioDialog {
  static void show(BuildContext context, ThemeData theme, ListaPrecio listaPrecio) {
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
            const Text('Eliminar Lista de Precio'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Estás seguro de que deseas eliminar esta lista de precio?',
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
                    'Valor: \$${listaPrecio.valor.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (listaPrecio.tipoHospedaje != null) ...[
                    const SizedBox(height: 8),
                    Text('Tipo Hospedaje: ${listaPrecio.tipoHospedaje!.descripcion}'),
                  ],
                  if (listaPrecio.tipoPrecio != null) ...[
                    const SizedBox(height: 4),
                    Text('Tipo Precio: ${listaPrecio.tipoPrecio!.descripcion}'),
                  ],
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
              context.read<ListaPrecioBloc>().add(DeleteListaPrecio(listaPrecio.idListaPrecio));
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