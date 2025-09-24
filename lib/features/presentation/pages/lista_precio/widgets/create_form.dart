import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/presentation/blocs/lista_precio/lista_precio_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_hospedaje/tipo_hospedaje_bloc.dart';
import 'package:reservas_app/features/presentation/blocs/tipo_precio/tipo_precio_bloc.dart';

class CreateListaPrecioDialog {
  static void show(BuildContext context, ThemeData theme) {
    final valorController = TextEditingController();
    int? selectedIdTipoHospedaje;
    int? selectedIdTipoPrecio;

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
              const Text('Nueva Lista de Precio'),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: valorController,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      prefixText: '\$ ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<TipoHospedajeBloc, TipoHospedajeState>(
                    builder: (context, state) {
                      if (state is! TipoHospedajeLoaded) {
                        context.read<TipoHospedajeBloc>().add(const LoadTipoHospedajes());
                        return const CircularProgressIndicator();
                      }
                      
                      return DropdownButtonFormField<int>(
                        value: selectedIdTipoHospedaje,
                        decoration: InputDecoration(
                          labelText: 'Tipo de Hospedaje',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: state.tipoHospedajes.map((tipo) {
                          return DropdownMenuItem<int>(
                            value: tipo.idTipoHospedaje,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tipo.descripcion,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                /*
                                Text(
                                  tipo.equipamiento,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                */
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIdTipoHospedaje = value;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<TipoPrecioBloc, TipoPrecioState>(
                    builder: (context, state) {
                      if (state is! TipoPrecioLoaded) {
                        context.read<TipoPrecioBloc>().add(const LoadTipoPrecios());
                        return const CircularProgressIndicator();
                      }
                      
                      return DropdownButtonFormField<int>(
                        value: selectedIdTipoPrecio,
                        decoration: InputDecoration(
                          labelText: 'Tipo de Precio',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: state.tipoPrecios.map((tipo) {
                          return DropdownMenuItem<int>(
                            value: tipo.idTipoPrecio,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tipo.descripcion,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                /*
                                Text(
                                  tipo.observacion,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                */
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIdTipoPrecio = value;
                          });
                        },
                      );
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
                if (valorController.text.trim().isNotEmpty && 
                    selectedIdTipoHospedaje != null &&
                    selectedIdTipoPrecio != null) {
                  final listaPrecio = ListaPrecio(
                    idListaPrecio: 0,
                    valor: int.parse(valorController.text.trim()),
                    idTipoHospedaje: selectedIdTipoHospedaje!,
                    idTipoPrecio: selectedIdTipoPrecio!,
                  );
                  
                  context.read<ListaPrecioBloc>().add(AddListaPrecio(listaPrecio));
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