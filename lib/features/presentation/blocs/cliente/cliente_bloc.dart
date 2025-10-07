import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/domain/usecases/cliente_usecases/create_cliente_usecase.dart';
import 'package:reservas_app/features/domain/usecases/cliente_usecases/delete_cliente_usecase.dart';
import 'package:reservas_app/features/domain/usecases/cliente_usecases/get_cliente_usecase.dart';
import 'package:reservas_app/features/domain/usecases/cliente_usecases/update_cliente_usecase.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final GetClientesUseCase _getClientesUseCase;
  final CreateClienteUseCase _createClienteUseCase;
  final UpdateClienteUseCase _updateClienteUseCase;
  final DeleteClienteUseCase _deleteClienteUseCase;

  ClienteBloc({
    required GetClientesUseCase getClientesUseCase,
    required CreateClienteUseCase createClienteUseCase,
    required UpdateClienteUseCase updateClienteUseCase,
    required DeleteClienteUseCase deleteClienteUseCase,
  })  : _getClientesUseCase = getClientesUseCase,
        _createClienteUseCase = createClienteUseCase,
        _updateClienteUseCase = updateClienteUseCase,
        _deleteClienteUseCase = deleteClienteUseCase,
        super(ClienteInitial()) {
    on<LoadClientes>(_onLoad);
    on<AddCliente>(_onAdd);
    on<UpdateCliente>(_onUpdate);
    on<DeleteCliente>(_onDelete);
    on<SearchClientes>(_onSearch);
  }

  Future<void> _onLoad(LoadClientes e, Emitter<ClienteState> emit) async {
    emit(ClienteLoading());
    try {
      final result = await _getClientesUseCase();
      result.fold(
        (failure) => emit(ClienteError(failure.message)),
        (clientes) => emit(ClienteLoaded(clientes)),
      );
    } catch (err) {
      emit(ClienteError(err.toString()));
    }
  }

  Future<void> _onAdd(AddCliente e, Emitter<ClienteState> emit) async {
    try {
      final result = await _createClienteUseCase(e.cliente);
      result.fold(
        (failure) => emit(ClienteError(failure.message)),
        (_) {
          emit(const ClienteSuccess('Cliente creado exitosamente'));
          add(const LoadClientes());
        },
      );
    } catch (err) {
      emit(ClienteError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateCliente e, Emitter<ClienteState> emit) async {
    try {
      final result = await _updateClienteUseCase(e.cliente);
      result.fold(
        (failure) => emit(ClienteError(failure.message)),
        (_) {
          emit(const ClienteSuccess('Cliente actualizado exitosamente'));
          add(const LoadClientes());
        },
      );
    } catch (err) {
      emit(ClienteError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteCliente e, Emitter<ClienteState> emit) async {
    try {
      final result = await _deleteClienteUseCase(e.id);
      result.fold(
        (failure) => emit(ClienteError(failure.message)),
        (_) {
          emit(const ClienteSuccess('Cliente eliminado exitosamente'));
          add(const LoadClientes());
        },
      );
    } catch (err) {
      emit(ClienteError(err.toString()));
    }
  }

  void _onSearch(SearchClientes event, Emitter<ClienteState> emit) {
    final currentState = state;
    if (currentState is ClienteLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(
          searchQuery: '',
          filteredClientes: [],
        ));
      } else {
        final filtered = _filterClientes(currentState.clientes, event.query);
        emit(currentState.copyWith(
          searchQuery: event.query,
          filteredClientes: filtered,
        ));
      }
    }
  }

  List<Cliente> _filterClientes(List<Cliente> clientes, String query) {
    final lowercaseQuery = query.toLowerCase();

    return clientes.where((cliente) {
      final nombreMatch = cliente.nombreCompleto.toLowerCase().contains(lowercaseQuery);
      final rutMatch = cliente.rut.toLowerCase().contains(lowercaseQuery);
      final telefonoMatch = cliente.telefono.toLowerCase().contains(lowercaseQuery);
      final emailMatch = cliente.email.toLowerCase().contains(lowercaseQuery);
      final idMatch = cliente.idCliente.toString().contains(lowercaseQuery);

      return nombreMatch || rutMatch || telefonoMatch || emailMatch || idMatch;
    }).toList();
  }
}