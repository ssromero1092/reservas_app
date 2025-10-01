import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/create_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/delete_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/get_tipo_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/tipo_precio_usecases/update_tipo_precio_usecase.dart';

part 'tipo_precio_event.dart';
part 'tipo_precio_state.dart';

class TipoPrecioBloc extends Bloc<TipoPrecioEvent, TipoPrecioState> {
  final GetTipoPreciosUseCase _getTipoPreciosUseCase;
  final CreateTipoPrecioUseCase _createTipoPrecioUseCase;
  final UpdateTipoPrecioUseCase _updateTipoPrecioUseCase;
  final DeleteTipoPrecioUseCase _deleteTipoPrecioUseCase;

  TipoPrecioBloc({
    required GetTipoPreciosUseCase getTipoPreciosUseCase,
    required CreateTipoPrecioUseCase createTipoPrecioUseCase,
    required UpdateTipoPrecioUseCase updateTipoPrecioUseCase,
    required DeleteTipoPrecioUseCase deleteTipoPrecioUseCase,
  })  : _getTipoPreciosUseCase = getTipoPreciosUseCase,
        _createTipoPrecioUseCase = createTipoPrecioUseCase,
        _updateTipoPrecioUseCase = updateTipoPrecioUseCase,
        _deleteTipoPrecioUseCase = deleteTipoPrecioUseCase,
        super(TipoPrecioInitial()) {
    on<LoadTipoPrecios>(_onLoad);
    on<AddTipoPrecio>(_onAdd);
    on<UpdateTipoPrecio>(_onUpdate);
    on<DeleteTipoPrecio>(_onDelete);
    on<SearchTipoPrecios>(_onSearch);
  }

  Future<void> _onLoad(LoadTipoPrecios event, Emitter<TipoPrecioState> emit) async {
    emit(TipoPrecioLoading());
    final result = await _getTipoPreciosUseCase();
    result.fold(
      (failure) => emit(TipoPrecioError(failure.message)),
      (tipoPrecios) => emit(TipoPrecioLoaded(tipoPrecios)),
    );
  }

  Future<void> _onAdd(AddTipoPrecio event, Emitter<TipoPrecioState> emit) async {
    try {
      final result = await _createTipoPrecioUseCase(event.tipoPrecio);
      result.fold(
        (failure) => emit(TipoPrecioError(failure.message)),
        (_) {
          emit(const TipoPrecioSuccess('Tipo de precio creado exitosamente'));
          add(const LoadTipoPrecios());
        },
      );
    } catch (err) {
      emit(TipoPrecioError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateTipoPrecio event, Emitter<TipoPrecioState> emit) async {
    try {
      final result = await _updateTipoPrecioUseCase(event.tipoPrecio);
      result.fold(
        (failure) => emit(TipoPrecioError(failure.message)),
        (_) {
          emit(const TipoPrecioSuccess('Tipo de precio actualizado exitosamente'));
          add(const LoadTipoPrecios());
        },
      );
    } catch (err) {
      emit(TipoPrecioError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteTipoPrecio event, Emitter<TipoPrecioState> emit) async {
    try {
      final result = await _deleteTipoPrecioUseCase(event.id);
      result.fold(
        (failure) => emit(TipoPrecioError(failure.message)),
        (_) {
          emit(const TipoPrecioSuccess('Tipo de precio eliminado exitosamente'));
          add(const LoadTipoPrecios());
        },
      );
    } catch (err) {
      emit(TipoPrecioError(err.toString()));
    }
  }

  void _onSearch(SearchTipoPrecios event, Emitter<TipoPrecioState> emit) {
    final currentState = state;
    if (currentState is TipoPrecioLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(
          searchQuery: '',
          filteredTipoPrecios: [],
        ));
      } else {
        final filtered = _filterTipoPrecios(currentState.tipoPrecios, event.query);
        emit(currentState.copyWith(
          searchQuery: event.query,
          filteredTipoPrecios: filtered,
        ));
      }
    }
  }

  List<TipoPrecio> _filterTipoPrecios(List<TipoPrecio> tipoPrecios, String query) {
    final lowercaseQuery = query.toLowerCase();

    return tipoPrecios.where((tipoPrecio) {
      // Buscar en descripcion
      final descripcionMatch = tipoPrecio.descripcion.toLowerCase().contains(lowercaseQuery);

      // Buscar en observacion
      final observacionMatch = tipoPrecio.observacion.toLowerCase().contains(lowercaseQuery);
      
      // Buscar en ID
      final idMatch = tipoPrecio.idTipoPrecio.toString().contains(lowercaseQuery);

      return descripcionMatch || 
             observacionMatch ||
             idMatch;
    }).toList();
  }
}
