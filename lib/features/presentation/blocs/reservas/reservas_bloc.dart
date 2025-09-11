import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/features/domain/entities/reserva.dart';
import 'package:reservas_app/features/domain/usecases/reservas_advance_use_case.dart';

part 'reservas_event.dart';
part 'reservas_state.dart';

class ReservasBloc extends Bloc<ReservasEvent, ReservasState> {
  final ReservasAdvanceUseCase _reservasAdvanceUseCase;

  ReservasBloc({required ReservasAdvanceUseCase reservasAdvanceUseCase}) : 
  _reservasAdvanceUseCase = reservasAdvanceUseCase,
  super(ReservasInitial()) {
    on<reservas>(_onReservas);
  }
      

  void _onReservas(reservas event, Emitter<ReservasState> emit) async {
    // Implement the logic for reservas event if needed
    print('Reservas event triggered');
    final result = await _reservasAdvanceUseCase();

    result.fold(
      (failure) {
        emit(ReservasError(failure.message));
      },
      (reservas) {
        emit(ReservasLoaded(reservas));
      },
    );
  }
}
