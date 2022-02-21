import 'package:rivia/res/models/riv_table.dart';
import 'package:rivia/res/models/rivia.dart';
import 'package:rivia/res/models/table_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Rivia', () {
    String en = 'Hello, I\'m Emir, Rivia and Catalin software founder!';
    String ru = 'Привет, меня зовут Эмир, я основатель Rivia и Catalin software';
    RivTable table = RivTable();
    Rivia rivia = Rivia(table.table);

    test('.decrypt(text, key)', () {
      expect(rivia.decryptText(rivia.encryptText(en, 'jora'), 'jora'),
          'Hello, I\'m Emir, Rivia and Catalin software founder!');
      expect(rivia.decryptText(rivia.encryptText(ru, 'жора'), 'жора'),
          'Привет, меня зовут Эмир, я основатель Rivia и Catalin software');

      expect(rivia.decryptText(rivia.encryptText(en, '1337'), '1337'),
          'Hello, I\'m Emir, Rivia and Catalin software founder!');
      expect(rivia.decryptText(rivia.encryptText(ru, '23FreK97:'), '23FreK97:'),
          'Привет, меня зовут Эмир, я основатель Rivia и Catalin software');
    });
  });
}