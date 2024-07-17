import 'package:excel/excel.dart';

class Round2Excel {
  exportRound2(startDate, endDate, electList) {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];

    for (int i = 0; i < 3; i++) sheet!.setColumnWidth(i, 20);

    CellStyle cellBold = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
      rotation: 0,
    );
    var cell = sheet!.cell(CellIndex.indexByString("A1"));
    cell.value = TextCellValue("Round 2 Election");
    cell.cellStyle = cellBold;

    var cell2 = sheet.cell(CellIndex.indexByString("A3"));
    cell2.value = TextCellValue("Start Date -  ${startDate}");
    cell2.cellStyle = cellBold;

    var cell3 = sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = TextCellValue("End Date -  ${endDate}");
    cell3.cellStyle = cellBold;

    var cell4 = sheet.cell(CellIndex.indexByString("A5"));
    cell4.value = TextCellValue("Name");
    cell4.cellStyle = cellBold;

    var cell5 = sheet.cell(CellIndex.indexByString("B5"));
    cell5.value = TextCellValue("Sama No");
    cell5.cellStyle = cellBold;

    var cell6 = sheet.cell(CellIndex.indexByString("C5"));
    cell6.value = TextCellValue("HPCSA");
    cell6.cellStyle = cellBold;

    var cellHDI = sheet.cell(CellIndex.indexByString("D5"));
    cellHDI.value = TextCellValue("HDI");
    cellHDI.cellStyle = cellBold;

    var cell7 = sheet.cell(CellIndex.indexByString("E5"));
    cell7.value = TextCellValue("Votes");
    cell7.cellStyle = cellBold;

    for (int i = 0; i < electList.length; i++) {
      var cell8 = sheet.cell(CellIndex.indexByString("A${i + 7}"));
      cell8.value = TextCellValue(electList[i]['name']);

      var cell9 = sheet.cell(CellIndex.indexByString("B${i + 7}"));
      cell9.value = TextCellValue(electList[i]['SamaNr']);

      var cell10 = sheet.cell(CellIndex.indexByString("C${i + 7}"));
      cell10.value = TextCellValue(electList[i]['hpca']);

      var cell12 = sheet.cell(CellIndex.indexByString("D${i + 7}"));
      cell12.value = TextCellValue(electList[i]['hdiStatus']);

      var cell11 = sheet.cell(CellIndex.indexByString("E${i + 7}"));
      cell11.value = TextCellValue(electList[i]['votes']);
    }

    var fileBytes = excel.save(fileName: 'Round2.xlsx');
  }
}
