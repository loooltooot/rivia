part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}
class DataProcessingState extends DataState {}

class DataEndedState extends DataState {
  String result;
  DataEndedState({required this.result});
}

class DataErrorState extends DataState {}
