import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/create_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/delete_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/get_tipo_hospedaje_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_hospedaje_usecases/update_tipo_hospedaje_usecase.dart';

part 'tipo_hospedaje_event.dart';
part 'tipo_hospedaje_state.dart';

class TipoHospedajeBloc extends Bloc<TipoHospedajeEvent, TipoHospedajeState> {
  final GetTipoHospedajesUseCase _getTipoHospedajesUseCase;
  final CreateTipoHospedajeUseCase _createTipoHospedajeUseCase;
  final UpdateTipoHospedajeUseCase _updateTipoHospedajeUseCase;
  final DeleteTipoHospedajeUseCase _deleteTipoHospedajeUseCase;

  TipoHospedajeBloc({
    required GetTipoHospedajesUseCase getTipoHospedajesUseCase,
    required CreateTipoHospedajeUseCase createTipoHospedajeUseCase,
    required UpdateTipoHospedajeUseCase updateTipoHospedajeUseCase,
    required DeleteTipoHospedajeUseCase deleteTipoHospedajeUseCase,
  })  : _getTipoHospedajesUseCase = getTipoHospedajesUseCase,
        _createTipoHospedajeUseCase = createTipoHospedajeUseCase,
        _updateTipoHospedajeUseCase = updateTipoHospedajeUseCase,
        _deleteTipoHospedajeUseCase = deleteTipoHospedajeUseCase,
        super(TipoHospedajeInitial()) {
    on<LoadTipoHospedajes>(_onLoad);
    on<AddTipoHospedaje>(_onAdd);
    on<UpdateTipoHospedaje>(_onUpdate);
    on<DeleteTipoHospedaje>(_onDelete);
    on<SearchTipoHospedajes>(_onSearch);
  }

  Future<void> _onLoad(LoadTipoHospedajes e, Emitter<TipoHospedajeState> emit) async {
    emit(TipoHospedajeLoading());
    try {
      final result = await _getTipoHospedajesUseCase();
      result.fold(
        (failure) => emit(TipoHospedajeError(failure.message)),
        (tipoHospedajes) => emit(TipoHospedajeLoaded(tipoHospedajes)),
      );
    } catch (err) {
      emit(TipoHospedajeError(err.toString()));
    }
  }

  Future<void> _onAdd(AddTipoHospedaje e, Emitter<TipoHospedajeState> emit) async {
    try {
      final result = await _createTipoHospedajeUseCase(e.tipoHospedaje);
      result.fold(
        (failure) => emit(TipoHospedajeError(failure.message)),
        (_) {
          emit(const TipoHospedajeSuccess('Tipo de hospedaje creado exitosamente'));
          add(const LoadTipoHospedajes());
        },
      );
    } catch (err) {
      emit(TipoHospedajeError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateTipoHospedaje e, Emitter<TipoHospedajeState> emit) async {
    try {
      final result = await _updateTipoHospedajeUseCase(e.tipoHospedaje);
      result.fold(
        (failure) => emit(TipoHospedajeError(failure.message)),
        (_) {
          emit(const TipoHospedajeSuccess('Tipo de hospedaje actualizado exitosamente'));
          add(const LoadTipoHospedajes());
        },
      );
    } catch (err) {
      emit(TipoHospedajeError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteTipoHospedaje e, Emitter<TipoHospedajeState> emit) async {
    try {
      final result = await _deleteTipoHospedajeUseCase(e.id);
      result.fold(
        (failure) => emit(TipoHospedajeError(failure.message)),
        (_) {
          emit(const TipoHospedajeSuccess('Tipo de hospedaje eliminado exitosamente'));
          add(const LoadTipoHospedajes());
        },
      );
    } catch (err) {
      emit(TipoHospedajeError(err.toString()));
    }
  }

  void _onSearch(SearchTipoHospedajes event, Emitter<TipoHospedajeState> emit) {
    final currentState = state;
    if (currentState is TipoHospedajeLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(
          searchQuery: '',
          filteredTipoHospedajes: [],
        ));
      } else {
        final filtered = _filterTipoHospedajes(currentState.tipoHospedajes, event.query);
        emit(currentState.copyWith(
          searchQuery: event.query,
          filteredTipoHospedajes: filtered,
        ));
      }
    }
  }

  List<TipoHospedaje> _filterTipoHospedajes(List<TipoHospedaje> tipoHospedajes, String query) {
    final lowercaseQuery = query.toLowerCase();

    return tipoHospedajes.where((tipoHospedaje) {
      // Buscar en descripcion
      final descripcionMatch = tipoHospedaje.descripcion.toLowerCase().contains(lowercaseQuery);

      // Buscar en equipamiento
      final equipamientoMatch = tipoHospedaje.equipamiento.toLowerCase().contains(lowercaseQuery);
      
      // Buscar en ID
      final idMatch = tipoHospedaje.idTipoHospedaje.toString().contains(lowercaseQuery);

      return descripcionMatch || 
             equipamientoMatch ||
             idMatch;
    }).toList();
  }
}