import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rivia/res/models/rivia.dart';

part 'rivia_event.dart';
part 'rivia_state.dart';

class RiviaBloc extends Bloc<RiviaEvent, RiviaState> {
  Rivia rivia = Rivia();

  RiviaBloc() : super(RiviaInitial()) {
    on<Encryption>((event, emit) {
      emit(ProcessingState());
      try {
        String result = rivia.encryptText(event.text, event.key);
        emit(EndedState(result: result));
      } catch (_) {
        emit(ErrorState());
      }
    });
    on<Decryption>((event, emit) {
      emit(ProcessingState());
      try {
        String result = rivia.decryptText(event.text, event.key);
        emit(EndedState(result: result));
      } catch (_) {
        emit(ErrorState());
      }
    });
  }
}
