import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rivia/res/db/db_provider.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<InsertKey>((event, emit) async {
      DatabaseProvider provider = DatabaseProvider.dbProvider;

      try {
        await provider.insertKey(event.key);
      } catch (_) {
        emit(DataErrorState());
      }
    });
    on<GetKey>((event, emit) async {
      DatabaseProvider provider = DatabaseProvider.dbProvider;

      emit(DataProcessingState());

      try {
        String key = await provider.getKey();
        emit(DataEndedState(result: key));
      } catch (_) {
        emit(DataErrorState());
      }
    });

    on<InsertTable>((event, emit) async {
      DatabaseProvider provider = DatabaseProvider.dbProvider;

      try {
        await provider.insertTable(event.table);
      } catch (_) {
        emit(DataErrorState());
      }
    });
    on<GetTable>((event, emit) async {
      DatabaseProvider provider = DatabaseProvider.dbProvider;

      emit(DataProcessingState());

      try {
        String? table = await provider.getTable();
        emit(DataEndedState(result: table ?? 'empty rivTable'));
      } catch (_) {
        emit(DataErrorState());
      }
    });
  }
}
