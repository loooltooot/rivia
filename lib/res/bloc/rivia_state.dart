part of 'rivia_bloc.dart';

@immutable
abstract class RiviaState {}

class RiviaInitial extends RiviaState {}
class ProcessingState extends RiviaState {}

class EndedState extends RiviaState {
  String result;
  EndedState({required this.result});
}

class ErrorState extends RiviaState {}
