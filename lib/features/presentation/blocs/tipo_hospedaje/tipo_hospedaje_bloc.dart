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
}