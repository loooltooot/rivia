import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rivia/res/db/db_provider.dart';
import 'package:rivia/res/models/riv_table.dart';
import 'package:rivia/res/models/rivia.dart';

part 'rivia_event.dart';
part 'rivia_state.dart';

class RiviaBloc extends Bloc<RiviaEvent, RiviaState> {
  RivTable rivTable = RivTable();
  late Rivia rivia;

  RiviaBloc() : super(RiviaInitial()) {
    on<Encryption>((event, emit) async {
      await refreshTable();
      rivia = Rivia(rivTable.table);

      emit(ProcessingState());

      try {
        String result = rivia.encryptText(event.text, event.key);
        emit(EndedState(result: result));
      } catch (_) {
        emit(ErrorState());
      }
    });
    on<Decryption>((event, emit) async {
      await refreshTable();
      rivia = Rivia(rivTable.table);

      emit(ProcessingState());

      try {
        String result = rivia.decryptText(event.text, event.key);
        emit(EndedState(result: result));
      } catch (_) {
        emit(ErrorState());
      }
    });
  }

  Future<void> refreshTable() async {
    DatabaseProvider provider = DatabaseProvider.dbProvider;

    String? temp = await provider.getTable();

    rivTable.setTable(temp);
  }
}
