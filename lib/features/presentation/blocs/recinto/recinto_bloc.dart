import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/create_recinto_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/delete_recinto_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/get_recintos_usecase.dart';
import 'package:reservas_app/features/domain/usecases/recinto_usecases/update_recinto_usecase.dart';

part 'recinto_event.dart';
part 'recinto_state.dart';

class RecintoBloc extends Bloc<RecintoEvent, RecintoState> {
  final GetRecintosUseCase _getRecintosUseCase;
  final CreateRecintoUseCase _createRecintoUseCase;
  final UpdateRecintoUseCase _updateRecintoUseCase;
  final DeleteRecintoUseCase _deleteRecintoUseCase;

  RecintoBloc({
    required GetRecintosUseCase getRecintosUseCase,
    required CreateRecintoUseCase createRecintoUseCase,
    required UpdateRecintoUseCase updateRecintoUseCase,
    required DeleteRecintoUseCase deleteRecintoUseCase,
  })  : _getRecintosUseCase = getRecintosUseCase,
        _createRecintoUseCase = createRecintoUseCase,
        _updateRecintoUseCase = updateRecintoUseCase,
        _deleteRecintoUseCase = deleteRecintoUseCase,
        super(RecintoInitial()) {
    on<LoadRecintos>(_onLoad);
    on<AddRecinto>(_onAdd);
    on<UpdateRecinto>(_onUpdate);
    on<DeleteRecinto>(_onDelete);
  }

  Future<void> _onLoad(LoadRecintos e, Emitter<RecintoState> emit) async {
    emit(RecintoLoading());
    try {
      final result = await _getRecintosUseCase();
      result.fold(
        (failure) => emit(RecintoError(failure.message)),
        (recintos) => emit(RecintoLoaded(recintos)),
      );
    } catch (err) {
      emit(RecintoError(err.toString()));
    }
  }

  Future<void> _onAdd(AddRecinto e, Emitter<RecintoState> emit) async {
    try {
      final result = await _createRecintoUseCase(e.recinto);
      result.fold(
        (failure) => emit(RecintoError(failure.message)),
        (_) {
          emit(const RecintoSuccess('Recinto creado exitosamente'));
          add(const LoadRecintos()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(RecintoError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateRecinto e, Emitter<RecintoState> emit) async {
    try {
      final result = await _updateRecintoUseCase(e.recinto);
      result.fold(
        (failure) => emit(RecintoError(failure.message)),
        (_) {
          emit(const RecintoSuccess('Recinto actualizado exitosamente'));
          add(const LoadRecintos()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(RecintoError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteRecinto e, Emitter<RecintoState> emit) async {
    try {
      final result = await _deleteRecintoUseCase(e.id);
      result.fold(
        (failure) => emit(RecintoError(failure.message)),
        (_) {
          emit(const RecintoSuccess('Recinto eliminado exitosamente'));
          add(const LoadRecintos()); // Recargar la lista
        },
      );
    } catch (err) {
      emit(RecintoError(err.toString()));
    }
  }
}
