part of 'simon_bloc.dart';

sealed class SimonState extends Equatable {
  const SimonState();
  
  @override
  List<Object> get props => [];
}

final class SimonInitial extends SimonState {}
