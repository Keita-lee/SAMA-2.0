//import 'package:excel/excel.dart';

class AcceptanceRoundExcel {
  exportAcceptance(startDate, endDate, acpList, branch) {
    /*   final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];

    for (int i = 0; i < 3; i++) sheet!.setColumnWidth(i, 20);

    CellStyle cellBold = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
      rotation: 0,
    );
    var cell = sheet!.cell(CellIndex.indexByString("A2"));
    cell.value = TextCellValue("Nomination Acceptance Round");
    cell.cellStyle = cellBold;

    var cellBrach = sheet!.cell(CellIndex.indexByString("A1"));
    cellBrach.value = TextCellValue(branch);
    cellBrach.cellStyle = cellBold;

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

    var cell7 = sheet.cell(CellIndex.indexByString("D5"));
    cell7.value = TextCellValue("Result");
    cell7.cellStyle = cellBold;

    for (int i = 0; i < acpList.length; i++) {
      var cell8 = sheet.cell(CellIndex.indexByString("A${i + 7}"));
      cell8.value = TextCellValue(acpList[i]['name']);

      var cell9 = sheet.cell(CellIndex.indexByString("B${i + 7}"));
      cell9.value = TextCellValue(acpList[i]['SamaNr']);

      var cell10 = sheet.cell(CellIndex.indexByString("C${i + 7}"));
      cell10.value = TextCellValue(acpList[i]['hpca']);

      var cell11 = sheet.cell(CellIndex.indexByString("D${i + 7}"));
      cell11.value = TextCellValue(acpList[i]['result']);
    }

    var fileBytes = excel.save(fileName: 'AcceptanceRound.xlsx');*/
  }
}
