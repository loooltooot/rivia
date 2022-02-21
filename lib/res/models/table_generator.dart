import 'dart:math';

import 'package:rivia/res/models/riv_table.dart';

class TableGenerator {
  static String generateTable(String seedStr) {
    RivTable rivTable = RivTable();
    int seed = 0;

    for(int el in seedStr.codeUnits) {
      seed += el;
    }

    seed *= 13;

    List<String> mainPart = rivTable.table.sublist(0, 432);
    List<String> olegPart = rivTable.table.sublist(432, 865);

    mainPart.shuffle(Random(seed));
    olegPart.shuffle(Random(seed));

    mainPart.addAll(olegPart);

    return mainPart.join('');
  }
}