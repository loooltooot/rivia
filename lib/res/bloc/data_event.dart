part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class InsertKey extends DataEvent {
  String key;
  InsertKey({required this.key});
}
class GetKey extends DataEvent {}

class InsertTable extends DataEvent {
  String table;
  InsertTable({required this.table});
}
class GetTable extends DataEvent {}
