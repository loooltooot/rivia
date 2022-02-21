import 'dart:math';

import 'package:rivia/res/models/riv_table.dart';

class TableGenerator {
  static String generateTable(String seedStr) {
    RivTable rivTable = RivTable();
    int seed = seedStr.split('').hashCode * 13 - 97;

    List<String> mainPart = rivTable.table.sublist(0, 432);
    List<String> olegPart = rivTable.table.sublist(432, 865);

    mainPart.shuffle(Random(seed));
    olegPart.shuffle(Random(seed));

    mainPart.addAll(olegPart);

    return mainPart.join('');
  }
}