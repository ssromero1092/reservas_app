import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simon_event.dart';
part 'simon_state.dart';

class SimonBloc extends Bloc<SimonEvent, SimonState> {
  SimonBloc() : super(SimonInitial()) {
    on<SimonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
