import 'dart:convert';

// import 'package:bms_programming/app/controller/MainController.dart';
// import 'package:bms_programming/app/providers/extensions/datagrid.dart';
import 'package:bms_salesco/app/providers/extensions/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;

import '../../widgets/Snack.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/input_fields.dart';
import '../controller/ConnectorControl.dart';
import '../controller/MainController.dart';
import '../data/DropDownValue.dart';
import '../data/rowfilter.dart';
import 'ApiFactory.dart';
import 'ExportData.dart';

class DataGridMenu {
  showGridMenu(PlutoGridStateManager stateManager, TapDownDetails details, BuildContext context, {String? exportFileName}) async {
    clearFilterList() {
      Get.find<MainController>().filters1[stateManager.hashCode.toString()] = RxList([]);
    }

    checkStateManagerIsNew() async {
      print("Hashcode======================> ${stateManager.hashCode}");
      if (Get.find<MainController>().filters1.containsKey(stateManager.hashCode.toString())) {
      } else {
        clearFilterList();
      }
    }

    applyfilters(PlutoGridStateManager stateManager) {
      var _filters = Get.find<MainController>().filters1[stateManager.hashCode.toString()] ?? [];
      stateManager.setFilter((element) => true);
      List<PlutoRow> _filterRows = stateManager.rows;
      for (var filter in _filters) {
        if (filter.operator == "equal") {
          _filterRows = _filterRows.where((element) => element.cells[filter.field]!.value == filter.value).toList();
        } else {
          _filterRows = _filterRows.where((element) => element.cells[filter.field]!.value != filter.value).toList();
        }
      }
      stateManager.setFilter((element) => _filterRows.contains(element));
    }

    customFilter(PlutoGridStateManager stateManager) {
      List _allValues = [];
      var _selectedValues = RxList([]);
      if (stateManager.currentCell != null) {
        _allValues = stateManager.rows.map((e) => e.cells[stateManager.currentCell!.column.field]!.value.toString()).toSet().toList();
      }
      Get.defaultDialog(
          title: "Custom Filter",
          content: SizedBox(
            width: Get.width / 2,
            height: Get.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stateManager.currentColumn?.title ?? "null"),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Obx(
                        () => Card(
                          color: _selectedValues.contains(_allValues[index]) ? Colors.deepPurple : Colors.white,
                          child: InkWell(
                            focusColor: Colors.deepPurple[200],
                            canRequestFocus: true,
                            onTap: () {
                              if (_selectedValues.contains(_allValues[index])) {
                                _selectedValues.remove(_allValues[index]);
                              } else {
                                _selectedValues.add(_allValues[index]);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                _allValues[index],
                                style: _selectedValues.contains(_allValues[index])
                                    ? TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)
                                    : TextStyle(
                                        fontSize: 12,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: _allValues.length,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.clear_rounded),
                label: Text("Cancel")),
            ElevatedButton.icon(
                onPressed: () {
                  stateManager.setFilter(
                      (element) => _selectedValues.any((value) => value == element.cells[stateManager.currentCell!.column.field]!.value.toString()));
                  Get.back();
                },
                icon: Icon(Icons.done),
                label: Text("Filter")),
          ]);
    }

    var selected = await showMenu(context: context, position: RelativeRect.fromSize(details.globalPosition & Size(40, 40), Get.size), items: [
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.find,
        height: 36,
        enabled: true,
        child: Text('Find', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.selectedfilter,
        height: 36,
        enabled: true,
        child: Text('Filter By Selection', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.excludeslected,
        height: 36,
        enabled: true,
        child: Text('Filter By Exclusion', style: TextStyle(fontSize: 13)),
      ),
      PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.removeLastFilter,
        height: 36,
        enabled: true,
        child: Obx(
          () {
            checkStateManagerIsNew();
            return ((Get.find<MainController>().filters1[stateManager.hashCode.toString()] ?? []).isEmpty)
                ? Text('Remove Last Filter', style: TextStyle(fontSize: 13))
                : PopupMenuButton<RowFilter>(
                    child: Text(
                      'Remove Last Filter',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    // onSelected: (Filter result) {
                    //   // setState(() { _selection = result; });
                    // Navigator.pop(context); },
                    itemBuilder: (BuildContext context) {
                      var _filters = Get.find<MainController>().filters1[stateManager.hashCode.toString()]!;
                      return <PopupMenuEntry<RowFilter>>[
                        for (var i = 0; i < _filters.length; i++)
                          PopupMenuItem(
                            child: Text("[${_filters[i].field}] ${_filters[i].operator == 'equal' ? '=' : '<>'} ${_filters[i].value}"),
                            onTap: () {
                              _filters.removeAt(i);
                              applyfilters(stateManager);
                              Get.back();
                            },
                          )
                      ];
                    },
                  );
          },
        ),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.clearfilter,
        height: 36,
        enabled: true,
        child: Text('Remove All Filters', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.export,
        height: 36,
        enabled: true,
        child: Text('Export To Excel', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.print,
        height: 36,
        enabled: true,
        child: Text('Print', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.customFilter,
        height: 36,
        enabled: true,
        child: Text('Custom Filter', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.exportToXml,
        height: 36,
        enabled: true,
        child: Text('Export To XML', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.noaction,
        height: 36,
        enabled: true,
        child: Text('Fast Export To Excel', style: TextStyle(fontSize: 13)),
      ),
      const PopupMenuItem<DataGridMenuItem>(
        value: DataGridMenuItem.exportToCSv,
        height: 36,
        enabled: true,
        child: Text('Export To CSV', style: TextStyle(fontSize: 13)),
      ),
    ]);

    switch (selected) {
      case DataGridMenuItem.selectedfilter:
        if (stateManager.currentCell != null) {
          Get.find<MainController>()
              .filters1[stateManager.hashCode.toString()]!
              .add(RowFilter(field: stateManager.currentCell!.column.field, operator: "equal", value: stateManager.currentCell!.value));
        }

        applyfilters(stateManager);
        // stateManager.setFilter((element) => stateManager.currentCell == null
        //     ? true
        //     : element.cells[stateManager.currentCell!.column.field]!.value ==
        //         stateManager.currentCell!.value);
        break;

      case DataGridMenuItem.excludeslected:
        if (stateManager.currentCell != null) {
          Get.find<MainController>()
              .filters1[stateManager.hashCode.toString()]!
              .add(RowFilter(field: stateManager.currentCell!.column.field, operator: "notequal", value: stateManager.currentCell!.value));
        }
        applyfilters(stateManager);

        // stateManager.setFilter((element) => stateManager.currentCell == null
        //     ? true
        //     : element.cells[stateManager.currentCell!.column.field]!.value !=
        //         stateManager.currentCell!.value);

        break;
      case DataGridMenuItem.removeLastFilter:
        // print(filters.length);
        // // filters.length > 1 ? filters.removeLast() : filters.clear();
        // applyfilters(stateManager);
        break;
      case DataGridMenuItem.clearfilter:
        clearFilterList();
        applyfilters(stateManager);

        break;
      case DataGridMenuItem.noaction:
        break;
      case DataGridMenuItem.export:
        ExportData().exportExcelFromJsonList(stateManager.toJson(), exportFileName ?? "Excel-${DateTime.now().toString()}");
        break;
      case DataGridMenuItem.exportPDF:

        // pluto_grid_export.PlutoGridDefaultPdfExport plutoGridPdfExport =
        //     pluto_grid_export.PlutoGridDefaultPdfExport(
        //   title: "ExportedData${DateTime.now().toString()}",
        //   creator: "BMS_Flutter",
        //   format: pluto_grid_export.PdfPageFormat.a4.landscape,
        // );
        // ExportData().exportPdfFromGridData(plutoGridPdfExport, stateManager);

        break;
      case DataGridMenuItem.print:
        pluto_grid_export.PlutoGridDefaultPdfExport plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
          title: exportFileName ?? "ExportedData${DateTime.now().toString()}",
          creator: "BMS_Flutter",
          format: pluto_grid_export.PdfPageFormat.a4.landscape,
        );
        ExportData().printFromGridData(plutoGridPdfExport, stateManager);

        break;
      case DataGridMenuItem.exportToCSv:
        String title = "csv_export";
        var exportCSV = pluto_grid_export.PlutoGridExport.exportCSV(stateManager);
        var exported = const Utf8Encoder().convert(
            // FIX Add starting \u{FEFF} / 0xEF, 0xBB, 0xBF
            // This allows open the file in Excel with proper character interpretation
            // See https://stackoverflow.com/a/155176
            '\u{FEFF}$exportCSV');

        FlutterFileSaver()
            .writeFileAsBytes(
              fileName: (exportFileName ?? 'export${DateTime.now().toString()}') + '.csv',
              bytes: exported,
            )
            .then((value) => Snack.callSuccess("File save to $value"));
        // await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
        break;
      case DataGridMenuItem.exportToXml:
        //TODO
        Get.find<ConnectorControl>().POSTMETHOD_FORMDATAWITHTYPE(
          api: ApiFactory.EXPORT_TO_XML,
          fun: (value) {
            ExportData().exportFilefromString(value, (exportFileName ?? 'export${DateTime.now().toString()}') + ".xml");
          },
          json: stateManager.toJson(),
        );
        break;
      case DataGridMenuItem.find:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     margin:
        //         EdgeInsets.symmetric(vertical: kToolbarHeight, horizontal: 10),
        //     duration: Duration(minutes: 10),
        //     behavior: SnackBarBehavior.floating,
        //     content: Container(
        //       height: 40,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           DropDownField.simpleDropDownwithWidthRatio(
        //               stateManager.columns
        //                   .map((e) =>
        //                       DropDownValue(key: e.field, value: e.title))
        //                   .toList(),
        //               (value) {},
        //               "Columns",
        //               0.20,
        //               context)
        //         ],
        //       ),
        //     )));

        showBottomSheet(
            context: context,
            builder: (context) {
              var _selectedColumn = "";
              TextEditingController _findctrl = TextEditingController();
              var _almost = RxBool(false);
              var _fromstart = RxBool(false);
              int? _index = 0;
              return Card(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: Get.width,
                    height: 50,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Column",
                              // style: TextStyle(
                              //   fontSize: SizeDefine.labelSize1,
                              //   color: Colors.black,
                              //   fontWeight: FontWeight.w500,
                              // ),
                            ),
                            const SizedBox(width: 5),
                            DropDownField.formDropDown1WidthMap(
                              stateManager.columns.map((e) => DropDownValue(key: e.field, value: e.title)).toList(),
                              (value) {
                                _selectedColumn = value.key!;
                              },
                              "Column",
                              0.15,
                              // context,
                              showtitle: false,
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Text(
                                "For",
                                // style: TextStyle(
                                //   fontSize: SizeDefine.labelSize1,
                                //   color: Colors.black,
                                //   fontWeight: FontWeight.w500,
                                // ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InputFields.formField1(hintTxt: "For", controller: _findctrl, width: 0.15, showTitle: false),
                          ],
                        ),
                        SizedBox(width: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                                onTap: () {
                                  _almost.value = !_almost.value;
                                },
                                child: Obx(
                                  () => Icon(_almost.value ? Icons.check_box_outlined : Icons.check_box_outline_blank_rounded),
                                )),
                            Text("Almost"),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                                onTap: () {
                                  _fromstart.value = !_fromstart.value;
                                },
                                child: Obx(
                                  () => Icon(_fromstart.value ? Icons.check_box_outlined : Icons.check_box_outline_blank_rounded),
                                )),
                            Text("From Start")
                          ],
                        ),
                        const SizedBox(width: 15),
                        Transform.scale(
                          scale: .85,
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                  label: Text(""),
                                  onPressed: () {
                                    if (_findctrl.text != "" && _selectedColumn != "") {
                                      var _slecetedRow = _almost.value
                                          ? stateManager.rows.firstWhereOrNull((element) => (element.cells[_selectedColumn]!.value
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(_findctrl.text.toLowerCase()) &&
                                              (_index == 0 || element.sortIdx > (_index ?? 0))))
                                          : stateManager.rows.firstWhere((element) =>
                                              (element.cells[_selectedColumn]!.value.toString().toLowerCase() == _findctrl.text.toLowerCase() &&
                                                  (_index == 0 || element.sortIdx > (_index ?? 0))));
                                      if (_slecetedRow == null) {
                                        stateManager.resetScrollToZero();

                                        Get.defaultDialog(content: Text("You Have reach the end !\nDo u want to restart?"), actions: [
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                _index = 0;
                                                stateManager.resetScrollToZero();
                                                Get.back();
                                                var _slecetedRow = _almost.value
                                                    ? stateManager.rows.firstWhereOrNull((element) => (element.cells[_selectedColumn]!.value
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(_findctrl.text.toLowerCase()) &&
                                                        (_index == 0 || element.sortIdx > (_index ?? 0))))
                                                    : stateManager.rows.firstWhere((element) =>
                                                        (element.cells[_selectedColumn]!.value.toString().toLowerCase() ==
                                                                _findctrl.text.toLowerCase() &&
                                                            (_index == 0 || element.sortIdx > (_index ?? 0))));
                                                print(_slecetedRow!.cells[_selectedColumn]!.value.toString() +
                                                    _slecetedRow.cells[_selectedColumn]!.value.runtimeType.toString());
                                                _index = _slecetedRow.sortIdx;
                                                stateManager.resetScrollToZero();

                                                stateManager.moveScrollByRow(PlutoMoveDirection.down, _slecetedRow.sortIdx - 1);

                                                stateManager.setKeepFocus(false);
                                                for (var element in stateManager.rows) {
                                                  stateManager.setRowChecked(element, false, notify: false);
                                                }
                                                stateManager.setRowChecked(_slecetedRow, true, notify: true);
                                                stateManager.setCurrentCell(_slecetedRow.cells[_selectedColumn], _slecetedRow.sortIdx);
                                              },
                                              icon: Icon(Icons.done),
                                              label: Text("YES")),
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(Icons.clear),
                                              label: Text("NO")),
                                        ]);
                                      } else {
                                        print(_slecetedRow.cells[_selectedColumn]!.value.toString() +
                                            _slecetedRow.cells[_selectedColumn]!.value.runtimeType.toString());
                                        if (_slecetedRow.sortIdx == 0) {
                                          _index = _index! + 1;
                                        } else {
                                          _index = _slecetedRow.sortIdx;
                                        }

                                        stateManager.resetScrollToZero();
                                        stateManager.moveScrollByRow(PlutoMoveDirection.down, _slecetedRow.sortIdx - 1);
                                        stateManager.setKeepFocus(false);
                                        for (var element in stateManager.rows) {
                                          stateManager.setRowChecked(element, false, notify: false);
                                        }
                                        stateManager.setRowChecked(_slecetedRow, true, notify: true);
                                        stateManager.setCurrentCell(_slecetedRow.cells[_selectedColumn], _slecetedRow.sortIdx);
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.keyboard_double_arrow_right_rounded)),
                              SizedBox(width: 15),
                              ElevatedButton.icon(
                                  label: Text(""),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.clear_outlined)),
                              SizedBox(width: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    stateManager.setFilter((element) => stateManager.currentCell == null
                                        ? true
                                        : element.cells[stateManager.currentCell!.column.field]!.value == stateManager.currentCell!.value);
                                  },
                                  child: Text("FS")),
                              SizedBox(width: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    stateManager.setFilter((element) => stateManager.currentCell == null
                                        ? true
                                        : element.cells[stateManager.currentCell!.column.field]!.value != stateManager.currentCell!.value);
                                  },
                                  child: Text("XF")),
                              SizedBox(width: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    stateManager.setFilter((element) => true);
                                  },
                                  child: Text("RF")),
                              SizedBox(width: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    customFilter(stateManager);
                                  },
                                  child: Text("CF")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });

        break;
      case DataGridMenuItem.customFilter:
        customFilter(stateManager);
        break;

      case null:
        break;
    }
  }
}

enum DataGridMenuItem {
  export,
  print,
  removeLastFilter,
  exportToCSv,
  exportPDF,
  exportToXml,
  find,
  selectedfilter,
  excludeslected,
  customFilter,
  clearfilter,
  noaction
}
