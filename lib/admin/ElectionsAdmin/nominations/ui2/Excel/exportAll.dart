//import 'package:excel/excel.dart';

class ExportAllData {
  exportAllData(
      round1Start,
      round1End,
      round1List,
      acceptanceStart,
      acceptanceEnd,
      acceptanceList,
      round2Start,
      round2End,
      round2List,
      chairStart,
      chairEnd,
      chairList,
      branch) {
    /* final excel = Excel.createExcel();

    final Round1Sheet = excel.sheets[excel.getDefaultSheet() as String];
    final Round2Sheet = excel.sheets[excel.getDefaultSheet() as String];
    final AcceptanceSheet = excel.sheets[excel.getDefaultSheet() as String];
    final Chair4Sheet = excel.sheets[excel.getDefaultSheet() as String];

    for (int i = 0; i < 3; i++) Round1Sheet!.setColumnWidth(i, 20);
    CellStyle cellBold = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
      rotation: 0,
    );
    var cell = Round1Sheet!.cell(CellIndex.indexByString("A1"));
    cell.value = TextCellValue("Round 1 Nominations");
    cell.cellStyle = cellBold;

    var cell2 = Round1Sheet.cell(CellIndex.indexByString("A3"));
    cell2.value = TextCellValue("Start Date -  ${round1Start}");
    cell2.cellStyle = cellBold;

    var cell3 = Round1Sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = TextCellValue("End Date -  ${round1End}");
    cell3.cellStyle = cellBold;

    var cell4 = Round1Sheet.cell(CellIndex.indexByString("A5"));
    cell4.value = TextCellValue("Name");
    cell4.cellStyle = cellBold;

    var cell5 = Round1Sheet.cell(CellIndex.indexByString("B5"));
    cell5.value = TextCellValue("Sama No");
    cell5.cellStyle = cellBold;

    var cell6 = Round1Sheet.cell(CellIndex.indexByString("C5"));
    cell6.value = TextCellValue("HPCSA");
    cell6.cellStyle = cellBold;

    var cell7 = Round1Sheet.cell(CellIndex.indexByString("D5"));
    cell7.value = TextCellValue("Nominations");
    cell7.cellStyle = cellBold;

    for (int i = 0; i < round1List.length; i++) {
      var cell8 = Round1Sheet.cell(CellIndex.indexByString("A${i + 7}"));
      cell8.value = TextCellValue(round1List[i]['name']);

      var cell9 = Round1Sheet.cell(CellIndex.indexByString("B${i + 7}"));
      cell9.value = TextCellValue(round1List[i]['SamaNr']);

      var cell10 = Round1Sheet.cell(CellIndex.indexByString("C${i + 7}"));
      cell10.value = TextCellValue(round1List[i]['hpca']);

      var cell11 = Round1Sheet.cell(CellIndex.indexByString("D${i + 7}"));
      cell11.value = TextCellValue(round1List[i]['nominations']);
    }

    for (int i = 0; i < 3; i++) AcceptanceSheet!.setColumnWidth(i, 20);

    var cellAcp = AcceptanceSheet!.cell(CellIndex.indexByString("A1"));
    cellAcp.value = TextCellValue("Nomination Acceptance Round");
    cellAcp.cellStyle = cellBold;

    var cellAcp2 = AcceptanceSheet.cell(CellIndex.indexByString("A3"));
    cellAcp2.value = TextCellValue("Start Date -  ${acceptanceStart}");
    cellAcp2.cellStyle = cellBold;

    var cellAcp3 = AcceptanceSheet.cell(CellIndex.indexByString("C3"));
    cellAcp3.value = TextCellValue("End Date -  ${acceptanceEnd}");
    cellAcp3.cellStyle = cellBold;

    var cellAcp4 = AcceptanceSheet.cell(CellIndex.indexByString("A5"));
    cellAcp4.value = TextCellValue("Name");
    cellAcp4.cellStyle = cellBold;

    var cellAcp5 = AcceptanceSheet.cell(CellIndex.indexByString("B5"));
    cellAcp5.value = TextCellValue("Sama No");
    cellAcp5.cellStyle = cellBold;

    var cellAcp6 = AcceptanceSheet.cell(CellIndex.indexByString("C5"));
    cellAcp6.value = TextCellValue("HPCSA");
    cellAcp6.cellStyle = cellBold;

    var cellAcp7 = AcceptanceSheet.cell(CellIndex.indexByString("D5"));
    cellAcp7.value = TextCellValue("Result");
    cellAcp7.cellStyle = cellBold;

    for (int i = 0; i < acceptanceList.length; i++) {
      var cellAcp8 = AcceptanceSheet.cell(CellIndex.indexByString("A${i + 7}"));
      cellAcp8.value = TextCellValue(acceptanceList[i]['name']);

      var cellAcp9 = AcceptanceSheet.cell(CellIndex.indexByString("B${i + 7}"));
      cellAcp9.value = TextCellValue(acceptanceList[i]['SamaNr']);

      var cellAcp10 =
          AcceptanceSheet.cell(CellIndex.indexByString("C${i + 7}"));
      cellAcp10.value = TextCellValue(acceptanceList[i]['hpca']);

      var cellAcp11 =
          AcceptanceSheet.cell(CellIndex.indexByString("D${i + 7}"));
      cellAcp11.value = TextCellValue(acceptanceList[i]['result']);
    }

    for (int i = 0; i < 3; i++) Round2Sheet!.setColumnWidth(i, 20);

    var round2Cell = Round2Sheet!.cell(CellIndex.indexByString("A1"));
    round2Cell.value = TextCellValue("Round 2 Election");
    round2Cell.cellStyle = cellBold;

    var round2Cell2 = Round2Sheet.cell(CellIndex.indexByString("A3"));
    round2Cell2.value = TextCellValue("Start Date -  ${round2Start}");
    round2Cell2.cellStyle = cellBold;

    var round2Cell3 = Round2Sheet.cell(CellIndex.indexByString("C3"));
    round2Cell3.value = TextCellValue("End Date -  ${round2End}");
    round2Cell3.cellStyle = cellBold;

    var round2Cell4 = Round2Sheet.cell(CellIndex.indexByString("A5"));
    round2Cell4.value = TextCellValue("Name");
    round2Cell4.cellStyle = cellBold;

    var round2Cell5 = Round2Sheet.cell(CellIndex.indexByString("B5"));
    round2Cell5.value = TextCellValue("Sama No");
    round2Cell5.cellStyle = cellBold;

    var round2Cell6 = Round2Sheet.cell(CellIndex.indexByString("C5"));
    round2Cell6.value = TextCellValue("HPCSA");
    round2Cell6.cellStyle = cellBold;

    var round2CellHDI = Round2Sheet.cell(CellIndex.indexByString("D5"));
    round2CellHDI.value = TextCellValue("HDI");
    round2CellHDI.cellStyle = cellBold;

    var round2Cell7 = Round2Sheet.cell(CellIndex.indexByString("E5"));
    round2Cell7.value = TextCellValue("Votes");
    round2Cell7.cellStyle = cellBold;

    for (int i = 0; i < round2List.length; i++) {
      var round2Cell8 = Round2Sheet.cell(CellIndex.indexByString("A${i + 7}"));
      round2Cell8.value = TextCellValue(round2List[i]['name']);

      var round2Cell9 = Round2Sheet.cell(CellIndex.indexByString("B${i + 7}"));
      round2Cell9.value = TextCellValue(round2List[i]['SamaNr']);

      var round2Cell10 = Round2Sheet.cell(CellIndex.indexByString("C${i + 7}"));
      round2Cell10.value = TextCellValue(round2List[i]['hpca']);

      var round2Cell12 = Round2Sheet.cell(CellIndex.indexByString("D${i + 7}"));
      round2Cell12.value = TextCellValue(round2List[i]['hdiStatus']);

      var round2Cell11 = Round2Sheet.cell(CellIndex.indexByString("E${i + 7}"));
      round2Cell11.value = TextCellValue(round2List[i]['votes']);
    }

    for (int i = 0; i < 3; i++) Chair4Sheet!.setColumnWidth(i, 20);

    var chair = Chair4Sheet!.cell(CellIndex.indexByString("A1"));
    cell.value = TextCellValue("Chairperson Election");
    cell.cellStyle = cellBold;

    var chair1 = Chair4Sheet.cell(CellIndex.indexByString("A3"));
    chair1.value = TextCellValue("Start Date -  ${chairStart}");
    chair1.cellStyle = cellBold;

    var chair3 = Chair4Sheet.cell(CellIndex.indexByString("C3"));
    chair3.value = TextCellValue("End Date -  ${chairEnd}");
    chair3.cellStyle = cellBold;

    var chair4 = Chair4Sheet.cell(CellIndex.indexByString("A5"));
    chair4.value = TextCellValue("Name");
    chair4.cellStyle = cellBold;

    var chair5 = Chair4Sheet.cell(CellIndex.indexByString("B5"));
    chair5.value = TextCellValue("Sama No");
    chair5.cellStyle = cellBold;

    var chair6 = Chair4Sheet.cell(CellIndex.indexByString("C5"));
    chair6.value = TextCellValue("HPCSA");
    chair6.cellStyle = cellBold;

    var chairhdiCell = Chair4Sheet.cell(CellIndex.indexByString("D5"));
    chairhdiCell.value = TextCellValue("Hdi");
    chairhdiCell.cellStyle = cellBold;

    var chair7 = Chair4Sheet.cell(CellIndex.indexByString("E5"));
    chair7.value = TextCellValue("Votes");
    chair7.cellStyle = cellBold;

    for (int i = 0; i < chairList.length; i++) {
      var chair8 = Chair4Sheet.cell(CellIndex.indexByString("A${i + 7}"));
      chair8.value = TextCellValue(chairList[i]['name']);

      var chair9 = Chair4Sheet.cell(CellIndex.indexByString("B${i + 7}"));
      chair9.value = TextCellValue(chairList[i]['SamaNr']);

      var chair10 = Chair4Sheet.cell(CellIndex.indexByString("C${i + 7}"));
      chair10.value = TextCellValue(chairList[i]['hpca']);

      var chair12 = Chair4Sheet.cell(CellIndex.indexByString("D${i + 7}"));
      chair12.value = TextCellValue(chairList[i]['hdiStatus']);

      var chair11 = Chair4Sheet.cell(CellIndex.indexByString("e${i + 7}"));
      chair11.value = TextCellValue(chairList[i]['votes']);
    }
    var fileBytes = excel.save(fileName: '${branch}.xlsx');*/
  }
}
