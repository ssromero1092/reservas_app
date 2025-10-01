import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/domain/usecases/lista_precio_usecases/create_lista_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/lista_precio_usecases/delete_lista_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/lista_precio_usecases/get_lista_precio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/lista_precio_usecases/update_lista_precio_usecase.dart';

part 'lista_precio_event.dart';
part 'lista_precio_state.dart';

class ListaPrecioBloc extends Bloc<ListaPrecioEvent, ListaPrecioState> {
  final GetListaPreciosUseCase _getListaPreciosUseCase;
  final CreateListaPrecioUseCase _createListaPrecioUseCase;
  final UpdateListaPrecioUseCase _updateListaPrecioUseCase;
  final DeleteListaPrecioUseCase _deleteListaPrecioUseCase;

  ListaPrecioBloc({
    required GetListaPreciosUseCase getListaPreciosUseCase,
    required CreateListaPrecioUseCase createListaPrecioUseCase,
    required UpdateListaPrecioUseCase updateListaPrecioUseCase,
    required DeleteListaPrecioUseCase deleteListaPrecioUseCase,
  })  : _getListaPreciosUseCase = getListaPreciosUseCase,
        _createListaPrecioUseCase = createListaPrecioUseCase,
        _updateListaPrecioUseCase = updateListaPrecioUseCase,
        _deleteListaPrecioUseCase = deleteListaPrecioUseCase,
        super(ListaPrecioInitial()) {
    on<LoadListaPrecios>(_onLoad);
    on<AddListaPrecio>(_onAdd);
    on<UpdateListaPrecio>(_onUpdate);
    on<DeleteListaPrecio>(_onDelete);
    on<SearchListaPrecios>(_onSearch);
  }

  Future<void> _onLoad(LoadListaPrecios e, Emitter<ListaPrecioState> emit) async {
    emit(ListaPrecioLoading());
    try {
      final result = await _getListaPreciosUseCase();
      result.fold(
        (failure) => emit(ListaPrecioError(failure.message)),
        (listaPrecios) => emit(ListaPrecioLoaded(listaPrecios)),
      );
    } catch (err) {
      emit(ListaPrecioError(err.toString()));
    }
  }

  Future<void> _onAdd(AddListaPrecio e, Emitter<ListaPrecioState> emit) async {
    try {
      final result = await _createListaPrecioUseCase(e.listaPrecio);
      result.fold(
        (failure) => emit(ListaPrecioError(failure.message)),
        (_) {
          emit(const ListaPrecioSuccess('Lista de precio creada exitosamente'));
          add(const LoadListaPrecios()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(ListaPrecioError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateListaPrecio e, Emitter<ListaPrecioState> emit) async {
    try {
      final result = await _updateListaPrecioUseCase(e.listaPrecio);
      result.fold(
        (failure) => emit(ListaPrecioError(failure.message)),
        (_) {
          emit(const ListaPrecioSuccess('Lista de precio actualizada exitosamente'));
          add(const LoadListaPrecios()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(ListaPrecioError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteListaPrecio e, Emitter<ListaPrecioState> emit) async {
    try {
      final result = await _deleteListaPrecioUseCase(e.id);
      result.fold(
        (failure) => emit(ListaPrecioError(failure.message)),
        (_) {
          emit(const ListaPrecioSuccess('Lista de precio eliminada exitosamente'));
          add(const LoadListaPrecios()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(ListaPrecioError(err.toString()));
    }
  }

  void _onSearch(SearchListaPrecios event, Emitter<ListaPrecioState> emit) {
    final currentState = state;
    if (currentState is ListaPrecioLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(
          searchQuery: '',
          filteredListaPrecios: [],
        ));
      } else {
        final filtered = _filterListaPrecios(currentState.listaPrecios, event.query);
        emit(currentState.copyWith(
          searchQuery: event.query,
          filteredListaPrecios: filtered,
        ));
      }
    }
  }

  List<ListaPrecio> _filterListaPrecios(List<ListaPrecio> listaPrecios, String query) {
    final lowercaseQuery = query.toLowerCase();
    
    return listaPrecios.where((listaPrecio) {
      // Buscar en valor
      final valorMatch = listaPrecio.valor.toString().contains(lowercaseQuery);
      
      // Buscar en tipo hospedaje
      final tipoHospedajeMatch = listaPrecio.tipoHospedaje?.descripcion
          .toLowerCase().contains(lowercaseQuery) ?? false;
      final equipamientoMatch = listaPrecio.tipoHospedaje?.equipamiento
          .toLowerCase().contains(lowercaseQuery) ?? false;
      
      // Buscar en tipo precio
      final tipoPrecioMatch = listaPrecio.tipoPrecio?.descripcion
          .toLowerCase().contains(lowercaseQuery) ?? false;
      final observacionMatch = listaPrecio.tipoPrecio?.observacion
          .toLowerCase().contains(lowercaseQuery) ?? false;
      
      // Buscar en ID
      final idMatch = listaPrecio.idListaPrecio.toString().contains(lowercaseQuery);
      
      return valorMatch || 
             tipoHospedajeMatch || 
             equipamientoMatch || 
             tipoPrecioMatch || 
             observacionMatch || 
             idMatch;
    }).toList();
  }
}