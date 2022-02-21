import 'package:rivia/res/models/riv_table.dart';

class Rivia {
  late List<String> table;

  Rivia(this.table);

  String encryptText(String text, String key) {
    String result = '';

    for(int i = 0, j = 0; i < text.length; i++, j++) {
      if(j == key.length) j = 0;

      int textIndex = table.indexOf(text[i]);
      int keyIndex = table.indexOf(key[j]);

      if(textIndex > keyIndex) {
        result += table[textIndex + keyIndex];
      } else {
        result += table[(textIndex - keyIndex).abs()];
      }
    }

    return result;
  }

  String decryptText(String text, String key) {
    String result = '';

    for(int i = 0, j = 0; i < text.length; i++, j++) {
      if(j == key.length) j = 0;

      int textIndex = table.indexOf(text[i]);
      int keyIndex = table.indexOf(key[j]);

      result += table[(textIndex - keyIndex).abs()];
    }

    return result;
  }
}