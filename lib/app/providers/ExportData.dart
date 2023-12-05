import 'package:bms_salesco/widgets/PlutoGridExport/lib/pluto_grid_export.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:get/get.dart';
// import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;
// import 'package:pluto_grid_export/pluto_grid_export.dart';

import 'package:bms_salesco/widgets/PlutoGridExport/lib/src/pluto_grid_export.dart' as pluto_grid_export;
import 'package:bms_salesco/widgets/PlutoGridExport/lib/src/pluto_grid_export.dart';
import 'package:printing/printing.dart';

import '../../widgets/LoadingDialog.dart';
import '../../widgets/Snack.dart';

class ExportData {
  @pragma('vm:entry-point')
  static void topLevelFunction(Map<String, dynamic> args) {
    // performs work in an isolate
  }
  exportExcelFromJsonList(jsonList, screenName) {
    if (jsonList!.isNotEmpty) {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel[screenName];
      excel.setDefaultSheet(screenName);
      sheetObject.appendRow((jsonList![0]).keys.toList());
      for (var element in jsonList!) {
        sheetObject.appendRow((element as Map).values.toList());
      }
      var value = excel.encode()!;
      String time = DateTime.now().toString();
      var fileBytes = excel.save(fileName: "$screenName.xlsx");
      // FlutterFileSaver()
      //     .writeFileAsBytes(
      //       fileName: 'fpc_search.xlsx',
      //       bytes: value as Uint8List,
      //     )
      //     .then((value) => Snack.callSuccess("File save to $value"));
    } else {
      Snack.callError("NO DATA TO EXPORT");
    }
  }
  exportExcelFromJsonList1(jsonList, screenName) {
    if (jsonList!.isNotEmpty) {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel[screenName];
      excel.setDefaultSheet(screenName);
      sheetObject.appendRow((jsonList![0]).keys.toList());
      for (var element in jsonList!) {
        sheetObject.appendRow((element as Map).values.toList());
      }
      var value = excel.encode()!;
      String time = DateTime.now().toString();
      var fileBytes = excel.save(fileName: "$screenName.xlsx");
      // FlutterFileSaver()
      //     .writeFileAsBytes(
      //       fileName: 'fpc_search.xlsx',
      //       bytes: value as Uint8List,
      //     )
      //     .then((value) => Snack.callSuccess("File save to $value"));
    } else {
      Snack.callError("NO DATA TO EXPORT");
    }
  }

  printFromGridData1(fileName,Uint8List data) async {
    await Printing.layoutPdf(
        format: PdfPageFormat.a4.landscape,
        name: fileName,
        onLayout: (PdfPageFormat format) async {
          // Update format onLayout
          return data;
        }).then((value) {
      // stateManager.setShowLoading(false);
    });
  }

  exportFilefromString(String data, String fileName) async {
    try {
      await FlutterFileSaver()
          .writeFileAsString(fileName: fileName, data: data)
          .then((value) {
        return value;
      });
    } catch (e) {
      Snack.callError("Failed To Save File");
    }
  }

  exportFilefromByte(Uint8List data, String fileName) async {
    try {
      await FlutterFileSaver()
          .writeFileAsBytes(fileName: fileName, bytes: data)
          .then((value) {
        return value;
      });
    } catch (e) {
      Snack.callError("Failed To Save File");
    }
  }

  printFromGridData(plutoGridPdfExport, stateManager) async {
    plutoGridPdfExport.themeData = ThemeData.withFont(
      base: Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'),
      ),
      bold: Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'),
      ),
    );
    await Printing.layoutPdf(
        format: PdfPageFormat.a4.landscape,
        name: plutoGridPdfExport.getFilename(),
        onLayout: (PdfPageFormat format) async {
          // Update format onLayout
          plutoGridPdfExport.format = format;
          return plutoGridPdfExport.export(stateManager);
        });
  }

  exportPdfFromGridData(
      PlutoGridDefaultPdfExport plutoGridPdfExport,
      stateManager) async {
    LoadingDialog.call();

    plutoGridPdfExport.themeData = ThemeData.withFont(
      base: Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'),
      ),
      bold: Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'),
      ),
    );
    await Printing.sharePdf(
        bytes: await plutoGridPdfExport.export(stateManager),
        filename: plutoGridPdfExport.getFilename());

    Get.back();
  }
}
