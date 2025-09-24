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
}