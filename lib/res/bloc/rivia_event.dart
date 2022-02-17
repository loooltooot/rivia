part of 'rivia_bloc.dart';

@immutable
abstract class RiviaEvent {}

class Encryption extends RiviaEvent {
  String text;
  String key;

  Encryption({required this.text,
    required this.key});
}

class Decryption extends RiviaEvent {
  String text;
  String key;

  Decryption({required this.text,
    required this.key});
}
