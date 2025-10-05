import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';
import 'package:reservas_app/features/domain/usecases/servicio_usecases/create_servicio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/servicio_usecases/delete_servicio_usecase.dart';
import 'package:reservas_app/features/domain/usecases/servicio_usecases/get_servicios_usecase.dart.dart';
import 'package:reservas_app/features/domain/usecases/servicio_usecases/update_servicio_usecase.dart';

part 'servicio_event.dart';
part 'servicio_state.dart';

class ServicioBloc extends Bloc<ServicioEvent, ServicioState> {
  final GetServiciosUseCase _getServiciosUseCase;
  final CreateServicioUseCase _createServicioUseCase;
  final UpdateServicioUseCase _updateServicioUseCase;
  final DeleteServicioUseCase _deleteServicioUseCase;

  ServicioBloc({
    required GetServiciosUseCase getServiciosUseCase,
    required CreateServicioUseCase createServicioUseCase,
    required UpdateServicioUseCase updateServicioUseCase,
    required DeleteServicioUseCase deleteServicioUseCase,
  })  : _getServiciosUseCase = getServiciosUseCase,
        _createServicioUseCase = createServicioUseCase,
        _updateServicioUseCase = updateServicioUseCase,
        _deleteServicioUseCase = deleteServicioUseCase,
        super(ServicioInitial()) {
    on<LoadServicios>(_onLoad);
    on<AddServicio>(_onAdd);
    on<UpdateServicio>(_onUpdate);
    on<DeleteServicio>(_onDelete);
    on<SearchServicios>(_onSearch);
  }

  Future<void> _onLoad(LoadServicios e, Emitter<ServicioState> emit) async {
    emit(ServicioLoading());
    final result = await _getServiciosUseCase();
    result.fold(
      (failure) => emit(ServicioError(failure.message)),
      (servicios) => emit(ServicioLoaded(servicios)),
    );
  }

  Future<void> _onAdd(AddServicio e, Emitter<ServicioState> emit) async {
    final result = await _createServicioUseCase(e.servicio);
    result.fold(
      (failure) => emit(ServicioError(failure.message)),
      (_) {
        emit(const ServicioSuccess('Servicio creado exitosamente'));
        add(const LoadServicios());
      },
    );
  }

  Future<void> _onUpdate(UpdateServicio e, Emitter<ServicioState> emit) async {
    final result = await _updateServicioUseCase(e.servicio);
    result.fold(
      (failure) => emit(ServicioError(failure.message)),
      (_) {
        emit(const ServicioSuccess('Servicio actualizado exitosamente'));
        add(const LoadServicios());
      },
    );
  }

  Future<void> _onDelete(DeleteServicio e, Emitter<ServicioState> emit) async {
    final result = await _deleteServicioUseCase(e.id);
    result.fold(
      (failure) => emit(ServicioError(failure.message)),
      (_) {
        emit(const ServicioSuccess('Servicio eliminado exitosamente'));
        add(const LoadServicios());
      },
    );
  }

  void _onSearch(SearchServicios event, Emitter<ServicioState> emit) {
    final currentState = state;
    if (currentState is ServicioLoaded) {
      final filtered = _filterServicios(currentState.servicios, event.query);
      emit(currentState.copyWith(
        filteredServicios: filtered,
        searchQuery: event.query,
      ));
    }
  }

  List<Servicio> _filterServicios(List<Servicio> servicios, String query) {
    final lowercaseQuery = query.toLowerCase();
    return servicios.where((servicio) {
      return servicio.descripcion.toLowerCase().contains(lowercaseQuery) ||
          servicio.observacion.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}