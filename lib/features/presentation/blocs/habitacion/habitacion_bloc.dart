import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/create_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/delete_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/get_habitacion_usecase.dart';
import 'package:reservas_app/features/domain/usecases/habitacion_usecases/update_habitacion_usecase.dart';

part 'habitacion_event.dart';
part 'habitacion_state.dart';

class HabitacionBloc extends Bloc<HabitacionEvent, HabitacionState> {
  final GetHabitacionesUseCase _getHabitacionesUseCase;
  final CreateHabitacionUseCase _createHabitacionUseCase;
  final UpdateHabitacionUseCase _updateHabitacionUseCase;
  final DeleteHabitacionUseCase _deleteHabitacionUseCase;

  HabitacionBloc({
    required GetHabitacionesUseCase getHabitacionesUseCase,
    required CreateHabitacionUseCase createHabitacionUseCase,
    required UpdateHabitacionUseCase updateHabitacionUseCase,
    required DeleteHabitacionUseCase deleteHabitacionUseCase,
  })  : _getHabitacionesUseCase = getHabitacionesUseCase,
        _createHabitacionUseCase = createHabitacionUseCase,
        _updateHabitacionUseCase = updateHabitacionUseCase,
        _deleteHabitacionUseCase = deleteHabitacionUseCase,
        super(HabitacionInitial()) {
    on<LoadHabitaciones>(_onLoad);
    on<AddHabitacion>(_onAdd);
    on<UpdateHabitacion>(_onUpdate);
    on<DeleteHabitacion>(_onDelete);
  }

  Future<void> _onLoad(LoadHabitaciones e, Emitter<HabitacionState> emit) async {
    emit(HabitacionLoading());
    try {
      final result = await _getHabitacionesUseCase();
      result.fold(
        (failure) => emit(HabitacionError(failure.message)),
        (habitaciones) => emit(HabitacionLoaded(habitaciones)),
      );
    } catch (err) {
      emit(HabitacionError(err.toString()));
    }
  }

  Future<void> _onAdd(AddHabitacion e, Emitter<HabitacionState> emit) async {
    try {
      final result = await _createHabitacionUseCase(e.habitacion);
      result.fold(
        (failure) => emit(HabitacionError(failure.message)),
        (_) {
          emit(const HabitacionSuccess('Habitación creada exitosamente'));
          add(const LoadHabitaciones());
        },
      );
    } catch (err) {
      emit(HabitacionError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateHabitacion e, Emitter<HabitacionState> emit) async {
    try {
      final result = await _updateHabitacionUseCase(e.habitacion);
      result.fold(
        (failure) => emit(HabitacionError(failure.message)),
        (_) {
          emit(const HabitacionSuccess('Habitación actualizada exitosamente'));
          add(const LoadHabitaciones());
        },
      );
    } catch (err) {
      emit(HabitacionError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteHabitacion e, Emitter<HabitacionState> emit) async {
    try {
      final result = await _deleteHabitacionUseCase(e.id);
      result.fold(
        (failure) => emit(HabitacionError(failure.message)),
        (_) {
          emit(const HabitacionSuccess('Habitación eliminada exitosamente'));
          add(const LoadHabitaciones());
        },
      );
    } catch (err) {
      emit(HabitacionError(err.toString()));
    }
  }
}