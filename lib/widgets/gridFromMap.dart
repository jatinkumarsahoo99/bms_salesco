import 'package:bms_salesco/app/providers/extensions/string_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../app/modules/AmagiSpotsReplacement/controllers/amagi_spots_replacement_controller.dart';
import '../app/providers/DataGridMenu.dart';
import '../app/providers/SizeDefine.dart';
import '../app/providers/Utils.dart';
import '../app/styles/theme.dart';

class DataGridFromMap extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMap({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.headerHeight = 30,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  final double headerHeight;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 10,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                        ? keyMapping!.containsKey(key)
                            ? keyMapping![key]
                            : key == "fpcCaption"
                                ? "FPC Caption"
                                : key.toString().pascalCaseToNormal()
                        : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                    (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData,
                            exportFileName: exportFileName);
                      },
                      child: Text(
                        (rendererContext.cell.value ?? "").toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: 25,
                width: (widthSpecificColumn != null &&
                        widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                        hideCode! &&
                            key.toString().toLowerCase() != "hourcode" &&
                            key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : Utils.normalCaseToPascalCase(key)
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData,
                          exportFileName: exportFileName);
                    },
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                    element.value == null ||
                    (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
                focusNode: focusNode!,
                autoScale: columnAutoResize,
                actionOnPress: actionOnPress,
                actionKey: actionIconKey,
                previousWidgetFN: previousWidgetFN,
                rowHeight: rowHeight,
                headerHeight: headerHeight),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}

class DataGridFromMap5 extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMap5({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 10,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                        ? keyMapping!.containsKey(key)
                            ? keyMapping![key]
                            : key == "fpcCaption"
                                ? "FPC Caption"
                                : key.toString().pascalCaseToNormal()
                        : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                    (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData,
                            exportFileName: exportFileName);
                      },
                      child: Text(
                        (rendererContext.cell.value ?? "").toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: 25,
                width: (widthSpecificColumn != null &&
                        widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                        hideCode! &&
                            key.toString().toLowerCase() != "hourcode" &&
                            key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : key.toString().pascalCaseToNormal()
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData,
                          exportFileName: exportFileName);
                    },
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                    element.value == null ||
                    (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
              focusNode: focusNode!,
              autoScale: columnAutoResize,
              actionOnPress: actionOnPress,
              actionKey: actionIconKey,
              previousWidgetFN: previousWidgetFN,
              rowHeight: rowHeight,
            ),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}

class DataGridFromMap3 extends StatelessWidget {
  DataGridFromMap3(
      {Key? key,
      required this.mapData,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcons,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = true,
      this.actionOnPress,
      this.onSelected,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.checkBoxColumnKey,
      this.showTitleInCheckBox,
      this.checkBoxStrComparison,
      this.uncheckCheckBoxStr,
      this.spaceActionKey,
      this.onActionKeyPress,
      this.enableColumnDoubleTap,
      this.onColumnHeaderDoubleTap,
      this.sort = PlutoColumnSort.none,
      this.previousWidgetFN,
      this.focusNode,
      this.gridStyle,
      this.specificWidth,
      this.rowHeight = 25,
      this.formateDateColumn,
      this.noEditcheckBoxColumnKey,
      this.removeKeysFromFile,
      this.widthSpecificColumn})
      : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;
  final double rowHeight;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final List<String>? removeKeysFromFile;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey, noEditcheckBoxColumnKey;
  final String? uncheckCheckBoxStr;
  final String? checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  Map<String, String>? formateDateColumn;
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    if (mapData.isNotEmpty) {
      /// adding NO.
      if (showSrNo!) {
        segColumn.add(PlutoColumn(
            title: "No.",
            enableRowChecked: false,
            readOnly: true,
            enableSorting: enableSort,
            enableRowDrag: false,
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey("no"))
                ? widthSpecificColumn!["no"]!
                : Utils.getColumnSize(key: "no", value: mapData[0][key]),
            enableAutoEditing: false,
            hide: hideCode! &&
                key.toString().toLowerCase() != "hourcode" &&
                key.toString().toLowerCase().contains("code"),
            enableColumnDrag: false,
            field: "no",
            type: PlutoColumnType.text()));
      }

      /// addidng columns

      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: const EdgeInsets.only(),
            sort: sort,
            titleSpan: enableColumnDoubleTap != null &&
                    enableColumnDoubleTap!.isNotEmpty &&
                    enableColumnDoubleTap!.contains(key)
                ? TextSpan(
                    text: doPasccal
                        ? key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                        : key,
                    recognizer: DoubleTapGestureRecognizer()
                      ..onDoubleTap = () {
                        if (onColumnHeaderDoubleTap != null) {
                          onColumnHeaderDoubleTap!(key);
                        }
                      },
                  )
                : null,
            title: doPasccal
                ? keyMapping != null
                    ? keyMapping!.containsKey(key)
                        ? keyMapping![key]
                        : key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                    : key.toString().pascalCaseToNormal()
                : key.toString(),
            enableRowChecked: false,
            renderer: ((rendererContext) {
              if (checkBoxColumnKey != null &&
                  checkBoxColumnKey!.isNotEmpty &&
                  checkBoxColumnKey!.contains(key)) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      canRequestFocus: false,
                      onTap: (noEditcheckBoxColumnKey != null &&
                              noEditcheckBoxColumnKey!.contains(key))
                          ? null
                          : () {
                              if (showTitleInCheckBox != null &&
                                  showTitleInCheckBox!.isNotEmpty) {
                                var temp = mapData[rendererContext.rowIdx][key];
                                temp['key'] =
                                    (temp['key'] == checkBoxStrComparison)
                                        ? uncheckCheckBoxStr
                                        : checkBoxStrComparison;
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  temp,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              } else {
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  rendererContext.cell.value ==
                                          checkBoxStrComparison
                                      ? uncheckCheckBoxStr
                                      : checkBoxStrComparison,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              }
                            },
                      child: Icon(
                        ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                        size: rowHeight <= 22 ? 18 : Get.theme.iconTheme.size,
                      ),
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName,removeKeysFromFile:removeKeysFromFile);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }

      /// adding rows
      for (var i = 0; i < mapData.length; i++) {
        Map row = mapData[i];

        Map<String, PlutoCell> cells = {};
        if (showSrNo!) {
          cells["no"] = PlutoCell(value: i + 1);
        }
        try {
          for (var element in row.entries) {
            try {
              cells[element.key] = PlutoCell(
                value: formateDateColumn != null &&
                        formateDateColumn!.containsKey(element.key) &&
                        element.value != null
                    ? DateFormat(dateFromat).format(
                        DateFormat(formateDateColumn![element.key])
                            .parse(element.value))
                    : element.value ?? "",
              );
            } catch (e) {
              print(
                  "Problem while formating date assigning original value ${e.toString()}");
              cells[element.key] = PlutoCell(
                value: element.value ?? "",
              );
            }
          }
          segRows.add(PlutoRow(cells: cells, sortIdx: i));
        } catch (e) {
          print("problem in adding rows");
        }
      }
    } else {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      );
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
          onChanged: onEdit,
          mode: mode ?? PlutoGridMode.normal,
          configuration: plutoGridConfiguration2(
            focusNode: focusNode!,
            rowHeight: rowHeight,
            autoScale: columnAutoResize,
            actionOnPress: actionOnPress,
            actionKey: actionIconKey ?? [],
            previousWidgetFN: previousWidgetFN,
          ).copyWith(style: gridStyle),
          rowColorCallback: colorCallback,
          onLoaded: (load) {
            if (widthSpecificColumn == null || widthSpecificColumn == {}) {
              load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.none,
                  resizeMode: PlutoResizeMode.normal));
            }

            load.stateManager.setKeepFocus(false);
            if (onload != null) {
              onload!(load);
            }
          },
          columns: segColumn,
          onRowDoubleTap: onRowDoubleTap,
          onSelected: onSelected,
          rows: segRows,
        ),
      ),
    );
  }
}

class DataGridFromMap6 extends StatelessWidget {
  DataGridFromMap6(
      {Key? key,
      required this.mapData,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcons,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = true,
      this.actionOnPress,
      this.onSelected,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.checkBoxColumnKey,
      this.showTitleInCheckBox,
      this.checkBoxStrComparison,
      this.uncheckCheckBoxStr,
      this.spaceActionKey,
      this.onActionKeyPress,
      this.enableColumnDoubleTap,
      this.onColumnHeaderDoubleTap,
      this.sort = PlutoColumnSort.none,
      this.previousWidgetFN,
      this.focusNode,
      this.gridStyle,
      this.specificWidth,
      this.rowHeight = 25,
      this.formateDateColumn,
      this.noEditcheckBoxColumnKey,
      this.widthSpecificColumn})
      : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;
  final double rowHeight;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey, noEditcheckBoxColumnKey;
  final dynamic uncheckCheckBoxStr;
  final dynamic checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  Map<String, String>? formateDateColumn;
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    if (mapData.isNotEmpty) {
      /// adding NO.
      if (showSrNo!) {
        segColumn.add(PlutoColumn(
            title: "No.",
            enableRowChecked: false,
            readOnly: true,
            enableSorting: enableSort,
            enableRowDrag: false,
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey("no"))
                ? widthSpecificColumn!["no"]!
                : Utils.getColumnSize(key: "no", value: mapData[0][key]),
            enableAutoEditing: false,
            hide: hideCode! &&
                key.toString().toLowerCase() != "hourcode" &&
                key.toString().toLowerCase().contains("code"),
            enableColumnDrag: false,
            field: "no",
            type: PlutoColumnType.text()));
      }

      /// addidng columns

      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: const EdgeInsets.only(),
            sort: sort,
            titleSpan: enableColumnDoubleTap != null &&
                    enableColumnDoubleTap!.isNotEmpty &&
                    enableColumnDoubleTap!.contains(key)
                ? TextSpan(
                    text: doPasccal
                        ? key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                        : key,
                    recognizer: DoubleTapGestureRecognizer()
                      ..onDoubleTap = () {
                        if (onColumnHeaderDoubleTap != null) {
                          onColumnHeaderDoubleTap!(key);
                        }
                      },
                  )
                : null,
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : key.toString().pascalCaseToNormal()
                : key,
            enableRowChecked: false,
            renderer: ((rendererContext) {
              if (checkBoxColumnKey != null &&
                  checkBoxColumnKey!.isNotEmpty &&
                  checkBoxColumnKey!.contains(key)) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      canRequestFocus: false,
                      onTap: (noEditcheckBoxColumnKey != null &&
                              noEditcheckBoxColumnKey!.contains(key))
                          ? null
                          : () {
                              if (showTitleInCheckBox != null &&
                                  showTitleInCheckBox!.isNotEmpty) {
                                var temp = mapData[rendererContext.rowIdx][key];
                                temp['key'] =
                                    (temp['key'] == checkBoxStrComparison)
                                        ? uncheckCheckBoxStr
                                        : checkBoxStrComparison;
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  temp,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              } else {
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  rendererContext.cell.value ==
                                          checkBoxStrComparison
                                      ? uncheckCheckBoxStr
                                      : checkBoxStrComparison,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              }
                            },
                      child: Icon(
                        ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Colors.deepPurpleAccent
                            : Colors.white,
                        size: rowHeight <= 22 ? 18 : Get.theme.iconTheme.size,
                      ),
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }

      /// adding rows
      for (var i = 0; i < mapData.length; i++) {
        Map row = mapData[i];

        Map<String, PlutoCell> cells = {};
        if (showSrNo!) {
          cells["no"] = PlutoCell(value: i + 1);
        }
        try {
          for (var element in row.entries) {
            try {
              cells[element.key] = PlutoCell(
                value: formateDateColumn != null &&
                        formateDateColumn!.containsKey(element.key) &&
                        element.value != null
                    ? DateFormat(dateFromat).format(
                        DateFormat(formateDateColumn![element.key])
                            .parse(element.value))
                    : element.value ?? "",
              );
            } catch (e) {
              print(
                  "Problem while formating date assigning original value ${e.toString()}");
              cells[element.key] = PlutoCell(
                value: element.value ?? "",
              );
            }
          }
          segRows.add(PlutoRow(cells: cells, sortIdx: i));
        } catch (e) {
          print("problem in adding rows");
        }
      }
    } else {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      );
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
          onChanged: onEdit,
          mode: mode ?? PlutoGridMode.normal,
          configuration: plutoGridConfiguration2(
            focusNode: focusNode!,
            rowHeight: rowHeight,
            autoScale: columnAutoResize,
            actionOnPress: actionOnPress,
            actionKey: actionIconKey ?? [],
            previousWidgetFN: previousWidgetFN,
          ).copyWith(style: gridStyle),
          rowColorCallback: colorCallback,
          onLoaded: (load) {
            if (widthSpecificColumn == null || widthSpecificColumn == {}) {
              load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.none,
                  resizeMode: PlutoResizeMode.normal));
            }

            load.stateManager.setKeepFocus(false);
            if (onload != null) {
              onload!(load);
            }
          },
          columns: segColumn,
          onRowDoubleTap: onRowDoubleTap,
          onSelected: onSelected,
          rows: segRows,
        ),
      ),
    );
  }
}

class DataGridFromMapForAmagiSpotReplacement extends StatelessWidget {
  DataGridFromMapForAmagiSpotReplacement(
      {Key? key,
      required this.mapData,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcons,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = true,
      this.actionOnPress,
      this.onSelected,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.checkBoxColumnKey,
      this.showTitleInCheckBox,
      this.checkBoxStrComparison,
      this.uncheckCheckBoxStr,
      this.spaceActionKey,
      this.onActionKeyPress,
      this.enableColumnDoubleTap,
      this.onColumnHeaderDoubleTap,
      this.sort = PlutoColumnSort.none,
      this.previousWidgetFN,
      this.focusNode,
      this.gridStyle,
      this.specificWidth,
      this.numTypeKeyList,
      this.widthSpecificColumn,
      this.isChannelGrid = false,
      this.isLocalSpotGrid = false,
      this.isMasterGrid = false,
      this.csvFormat = false,
      this.onContextMenuClick})
      : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;

  bool? isChannelGrid;
  bool? isMasterGrid;
  bool? isLocalSpotGrid;

  final List<String?>? numTypeKeyList;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? csvFormat;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final Function(DataGridMenuItem, int, PlutoColumnRendererContext)?
      onContextMenuClick;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey;
  final String? uncheckCheckBoxStr;
  final String? checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    /// adding NO.
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 25,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }

    /// addidng columns
    for (var key in mapData[0].keys) {
      segColumn.add(PlutoColumn(
          titlePadding: const EdgeInsets.only(),
          sort: sort,
          titleSpan: enableColumnDoubleTap != null &&
                  enableColumnDoubleTap!.isNotEmpty &&
                  enableColumnDoubleTap!.contains(key)
              ? TextSpan(
                  text: doPasccal
                      ? key == "neW_ID"
                          ? "NEW_ID"
                          : Utils.normalCaseToPascalCase(key)
                      : key,
                  recognizer: DoubleTapGestureRecognizer()
                    ..onDoubleTap = () {
                      if (onColumnHeaderDoubleTap != null) {
                        onColumnHeaderDoubleTap!(key);
                      }
                    },
                )
              : null,
          title: doPasccal
              ? key == "neW_ID"
                  ? "NEW_ID"
                  : key.toString().pascalCaseToNormal()
              : key,
          enableRowChecked: false,
          renderer: ((rendererContext) {
            if (checkBoxColumnKey != null &&
                checkBoxColumnKey!.isNotEmpty &&
                checkBoxColumnKey!.contains(key)) {
              return InkWell(
                canRequestFocus: false,
                onTap: () {
                  if (showTitleInCheckBox != null &&
                      showTitleInCheckBox!.isNotEmpty) {
                    var temp = mapData[rendererContext.rowIdx][key];
                    temp['key'] = (temp['key'] == checkBoxStrComparison)
                        ? uncheckCheckBoxStr
                        : checkBoxStrComparison;
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      temp,
                      force: true,
                      callOnChangedEvent: true,
                      notify: true,
                    );
                  } else {
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      rendererContext.cell.value == checkBoxStrComparison
                          ? uncheckCheckBoxStr
                          : checkBoxStrComparison,
                      force: true,
                      callOnChangedEvent: true,
                      notify: true,
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      ((showTitleInCheckBox != null &&
                                      showTitleInCheckBox!.isNotEmpty)
                                  ? mapData[rendererContext.rowIdx][key]['key']
                                  : rendererContext.cell.value) ==
                              checkBoxStrComparison
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: ((showTitleInCheckBox != null &&
                                      showTitleInCheckBox!.isNotEmpty)
                                  ? mapData[rendererContext.rowIdx][key]['key']
                                  : rendererContext.cell.value) ==
                              checkBoxStrComparison
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                ),
              );
            } else if (isChannelGrid == true) {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  if (onContextMenuClick == null) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        exportFileName: exportFileName);
                  } else {
                    DataGridMenu().showGridMenuForAmagiSpotReplacement(
                        rendererContext.stateManager, detail, context,
                        exportFileName: exportFileName,
                        onPressedClick: onContextMenuClick,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        plutoContext: rendererContext);
                  }
                },
                child: Text(
                  (rendererContext.cell.value ?? " ").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SizeDefine.columnTitleFontSize,
                    fontWeight: getChannelFont(rendererContext),
                    // color: getChannelColor(rendererContext)
                  ),
                ),
              );
            } else if (isMasterGrid == true) {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  if (onContextMenuClick == null) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        exportFileName: exportFileName);
                  } else {
                    DataGridMenu().showGridMenuForAmagiSpotReplacement(
                        rendererContext.stateManager, detail, context,
                        exportFileName: exportFileName,
                        onPressedClick: onContextMenuClick,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        plutoContext: rendererContext);
                  }
                },
                child: Text(
                  (rendererContext.cell.value ?? " ").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                      fontWeight: getMasterFont(rendererContext)),
                ),
              );
            } else if (isLocalSpotGrid == true) {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  if (onContextMenuClick == null) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        exportFileName: exportFileName);
                  } else {
                    DataGridMenu().showGridMenuForAmagiSpotReplacement(
                        rendererContext.stateManager, detail, context,
                        exportFileName: exportFileName,
                        onPressedClick: onContextMenuClick,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        plutoContext: rendererContext);
                  }
                },
                child: Text(
                  (rendererContext.cell.value ?? " ").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                      fontWeight: getLocalFont(rendererContext)),
                ),
              );
            } else {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  if (onContextMenuClick == null) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        exportFileName: exportFileName);
                  } else {
                    DataGridMenu().showGridMenuForAmagiSpotReplacement(
                        rendererContext.stateManager, detail, context,
                        exportFileName: exportFileName,
                        onPressedClick: onContextMenuClick,
                        csvFormat: csvFormat ?? false,
                        data: mapData,
                        plutoContext: rendererContext);
                  }
                },
                child: Text(
                  (rendererContext.cell.value ?? " ").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SizeDefine.columnTitleFontSize,
                  ),
                ),
              );
            }
          }),
          enableSorting: enableSort,
          enableRowDrag: false,
          enableEditingMode: editKeys != null && editKeys!.contains(key),
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 25,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey(key))
              ? widthSpecificColumn![key]!
              : Utils.getColumnSize(key: key, value: mapData[0][key]),
          // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
          enableAutoEditing: false,
          hide: showonly == null
              ? (hideKeys != null && hideKeys!.contains(key)) ||
                  hideCode! &&
                      key.toString().toLowerCase() != "hourcode" &&
                      key.toString().toLowerCase().contains("code")
              : !showonly!.contains(key),
          enableColumnDrag: false,
          field: key,
          type: (numTypeKeyList != null &&
                  numTypeKeyList!.isNotEmpty &&
                  numTypeKeyList!.contains(key))
              ? PlutoColumnType.number()
              : PlutoColumnType.text()));
    }

    /// adding rows
    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.value,
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
          onChanged: onEdit,
          mode: mode ?? PlutoGridMode.normal,
          configuration: plutoGridConfiguration2(
            focusNode: focusNode!,
            autoScale: columnAutoResize,
            actionOnPress: actionOnPress,
            actionKey: actionIconKey ?? [],
            previousWidgetFN: previousWidgetFN,
          ).copyWith(style: gridStyle),
          rowColorCallback: colorCallback,
          onLoaded: (load) {
            if (widthSpecificColumn == null || widthSpecificColumn == {}) {
              load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.none,
                  resizeMode: PlutoResizeMode.normal));
            }

            load.stateManager.setKeepFocus(false);
            if (onload != null) {
              onload!(load);
            }
          },
          columns: segColumn,
          onRowDoubleTap: onRowDoubleTap,
          onSelected: onSelected,
          rows: segRows,
        ),
      ),
    );
  }
}

class DataGridFromMapAmagiDialog extends StatelessWidget {
  DataGridFromMapAmagiDialog(
      {Key? key,
      required this.mapData,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcons,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = true,
      this.actionOnPress,
      this.onSelected,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.checkBoxColumnKey,
      this.showTitleInCheckBox,
      this.checkBoxStrComparison,
      this.uncheckCheckBoxStr,
      this.spaceActionKey,
      this.onActionKeyPress,
      this.enableColumnDoubleTap,
      this.onColumnHeaderDoubleTap,
      this.sort = PlutoColumnSort.none,
      this.previousWidgetFN,
      this.focusNode,
      this.gridStyle,
      this.specificWidth,
      this.numTypeKeyList,
      this.widthSpecificColumn,
      this.summary = false,
      this.csvFormat = false,
      this.summaryCase = false})
      : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;
  final List<String?>? numTypeKeyList;
  final bool? showSrNo;
  final bool? summary;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  final bool? csvFormat;
  final bool? summaryCase;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey;
  final String? uncheckCheckBoxStr;
  final String? checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    /// adding NO.
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 25,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }

    /// addidng columns
    for (var key in mapData[0].keys) {
      segColumn.add(PlutoColumn(
          titlePadding: const EdgeInsets.only(),
          sort: sort,
          titleSpan: enableColumnDoubleTap != null &&
                  enableColumnDoubleTap!.isNotEmpty &&
                  enableColumnDoubleTap!.contains(key)
              ? TextSpan(
                  text: doPasccal
                      ? key == "som"
                          ? "SOM"
                          : Utils.normalCaseToPascalCase(key)
                      : key,
                  recognizer: DoubleTapGestureRecognizer()
                    ..onDoubleTap = () {
                      if (onColumnHeaderDoubleTap != null) {
                        onColumnHeaderDoubleTap!(key);
                      }
                    },
                )
              : null,
          title: doPasccal
              ? key == "som"
                  ? "SOM"
                  : ((summaryCase == true)
                      ? key
                      : Utils.normalCaseToPascalCase(key))
              : key,
          enableRowChecked: false,
          renderer: ((rendererContext) {
            if (checkBoxColumnKey != null &&
                checkBoxColumnKey!.isNotEmpty &&
                checkBoxColumnKey!.contains(key)) {
              return InkWell(
                canRequestFocus: false,
                onTap: () {
                  if (showTitleInCheckBox != null &&
                      showTitleInCheckBox!.isNotEmpty) {
                    var temp = mapData[rendererContext.rowIdx][key];
                    temp['key'] = (temp['key'] == checkBoxStrComparison)
                        ? uncheckCheckBoxStr
                        : checkBoxStrComparison;
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      temp,
                      force: true,
                      callOnChangedEvent: true,
                      notify: true,
                    );
                  } else {
                    rendererContext.stateManager.changeCellValue(
                      rendererContext.cell,
                      rendererContext.cell.value == checkBoxStrComparison
                          ? uncheckCheckBoxStr
                          : checkBoxStrComparison,
                      force: true,
                      callOnChangedEvent: true,
                      notify: true,
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      ((showTitleInCheckBox != null &&
                                      showTitleInCheckBox!.isNotEmpty)
                                  ? mapData[rendererContext.rowIdx][key]['key']
                                  : rendererContext.cell.value) ==
                              checkBoxStrComparison
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: ((showTitleInCheckBox != null &&
                                      showTitleInCheckBox!.isNotEmpty)
                                  ? mapData[rendererContext.rowIdx][key]['key']
                                  : rendererContext.cell.value) ==
                              checkBoxStrComparison
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                ),
              );
            } else if (summary == true) {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  DataGridMenu().showGridMenu(
                      rendererContext.stateManager, detail, context,
                      csvFormat: csvFormat ?? false,
                      data: mapData,
                      exportFileName: exportFileName);
                },
                child: Container(
                  color: getColors(rendererContext),
                  height: 30,
                  child: Text(
                    rendererContext.cell.value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onSecondaryTapDown: (detail) {
                  DataGridMenu().showGridMenu(
                      rendererContext.stateManager, detail, context,
                      csvFormat: csvFormat ?? false,
                      data: mapData,
                      exportFileName: exportFileName);
                },
                child: Text(
                  rendererContext.cell.value.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SizeDefine.columnTitleFontSize,
                  ),
                ),
              );
            }
          }),
          enableSorting: enableSort,
          enableRowDrag: false,
          enableEditingMode: editKeys != null && editKeys!.contains(key),
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 25,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey(key))
              ? widthSpecificColumn![key]!
              : 250,
          // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
          enableAutoEditing: false,
          hide: showonly == null
              ? (hideKeys != null && hideKeys!.contains(key)) ||
                  hideCode! &&
                      key.toString().toLowerCase() != "hourcode" &&
                      key.toString().toLowerCase().contains("code")
              : !showonly!.contains(key),
          enableColumnDrag: false,
          field: key,
          type: (numTypeKeyList != null &&
                  numTypeKeyList!.isNotEmpty &&
                  numTypeKeyList!.contains(key))
              ? PlutoColumnType.number()
              : PlutoColumnType.text()));
    }

    /// adding rows
    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.value,
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
          onChanged: onEdit,
          mode: mode ?? PlutoGridMode.normal,
          configuration: plutoGridConfiguration2(
            focusNode: focusNode!,
            autoScale: columnAutoResize,
            actionOnPress: actionOnPress,
            actionKey: actionIconKey ?? [],
            previousWidgetFN: previousWidgetFN,
          ).copyWith(style: gridStyle),
          rowColorCallback: colorCallback,
          onLoaded: (load) {
            if (widthSpecificColumn == null || widthSpecificColumn == {}) {
              load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.none,
                  resizeMode: PlutoResizeMode.normal));
            }

            load.stateManager.setKeepFocus(false);
            if (onload != null) {
              onload!(load);
            }
          },
          columns: segColumn,
          onRowDoubleTap: onRowDoubleTap,
          onSelected: onSelected,
          rows: segRows,
        ),
      ),
    );
  }
}

class DataGridFromMap4 extends StatelessWidget {
  final Map<String, double>? witdthSpecificColumn;
  final bool canShowFilter;
  DataGridFromMap4(
      {Key? key,
      required this.mapData,
      this.canShowFilter = true,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcon,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = false,
      this.actionOnPress,
      this.onSelected,
      this.onRowCheck,
      this.onContextMenuClick,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.focusNode,
      this.previousWidgetFN,
      this.witdthSpecificColumn,
      this.csvFormat = false,
      this.showOnlyCheckBox,
      this.removeKeysFromFile})
      : super(key: key);
  final List mapData;
  bool enableSort;

  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final List<String>? removeKeysFromFile;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final Function(DataGridMenuItem, int)? onContextMenuClick;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final Function(PlutoGridOnRowCheckedEvent)? onRowCheck;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  final bool? csvFormat;
  final bool? showOnlyCheckBox;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "No.",
          // titleSpan: TextSpan(
          //   text: "No.",
          //   recognizer: DoubleTapGestureRecognizer()
          //     ..onDoubleTap = () {
          //       if (onContextMenuClick == null) {
          //         DataGridMenu().showGridMenu(rendererContext.stateManager, detail, context, exportFileName: exportFileName);
          //       } else {
          //         DataGridMenu().showGridCustomMenu(rendererContext.stateManager, detail, context,
          //             exportFileName: exportFileName, onPressedClick: onContextMenuClick, plutoContext: rendererContext);
          //       }
          //     },
          // ),
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          width: 40,
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          cellPadding: const EdgeInsets.all(0),
          renderer: ((rendererContext) {
            // print("On rendererContext called");
            return GestureDetector(
              onSecondaryTapDown: canShowFilter
                  ? (detail) {
                      if (onContextMenuClick == null) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            csvFormat: csvFormat ?? false,
                            data: mapData,
                            removeKeysFromFile: removeKeysFromFile);
                      } else {
                        DataGridMenu().showGridCustomMenu(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            onPressedClick: onContextMenuClick,
                            data: mapData,
                            plutoContext: rendererContext);
                      }
                    }
                  : null,
              child: Container(
                  // height: 25,
                  height: double.infinity,
                  // width: Utils.getColumnSize1(key: key, value: mapData[0][key]),
                  // padding: EdgeInsets.only(
                  //   left:
                  // ),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.transparent, width: 0.01),
                      borderRadius: BorderRadius.circular(1),
                      color: Colors.white),
                  alignment: Alignment.center,
                  // color: (key == "epsNo" || key == "tapeid" || key == "status") ? ColorData.cellColor(rendererContext.row.cells[key]?.value, key) : null,
                  child: Text(
                    (rendererContext.rowIdx + 1).toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  )),
            );
          }),
          // renderer: (rendererContext) {
          //   return GestureDetector(
          //     onSecondaryTapDown: canShowFilter
          //         ? (detail) {
          //             if (onContextMenuClick == null) {
          //               DataGridMenu().showGridMenu(
          //                   rendererContext.stateManager, detail, context,
          //                   exportFileName: exportFileName);
          //             } else {
          //               DataGridMenu().showGridCustomMenu(
          //                   rendererContext.stateManager, detail, context,
          //                   exportFileName: exportFileName,
          //                   onPressedClick: onContextMenuClick,
          //                   plutoContext: rendererContext);
          //             }
          //           }
          //         : null,
          //     child: Text(
          //       (rendererContext.cell.value ?? "").toString(),
          //       style: TextStyle(
          //         fontSize: SizeDefine.columnTitleFontSize,
          //       ),
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   );
          // },
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(PlutoColumn(
              minWidth: 25,
              title: doPasccal
                  ? keyMapping != null
                      ? keyMapping!.containsKey(key)
                          ? keyMapping![key]
                          : key == "fpcCaption"
                              ? "FPC Caption"
                              : key.toString().pascalCaseToNormal()
                      : key.toString().pascalCaseToNormal()
                  : key.toString(),
              enableRowChecked:
                  (checkRow == true && key == checkRowKey) ? true : false,
              renderer: ((rendererContext) {
                if (actionIconKey != null && key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: canShowFilter
                        ? (detail) {
                            if (onContextMenuClick == null) {
                              DataGridMenu().showGridMenu(
                                  rendererContext.stateManager, detail, context,
                                  exportFileName: exportFileName,
                                  csvFormat: csvFormat ?? false,
                                  data: mapData,
                                  removeKeysFromFile: removeKeysFromFile);
                            } else {
                              DataGridMenu().showGridCustomMenu(
                                  rendererContext.stateManager, detail, context,
                                  exportFileName: exportFileName,
                                  onPressedClick: onContextMenuClick,
                                  data: mapData,
                                  plutoContext: rendererContext);
                            }
                          }
                        : null,
                    child: Text(
                      (rendererContext.cell.value ?? "").toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              }),
              enableSorting: enableSort,
              enableRowDrag: false,
              enableEditingMode: editKeys != null && editKeys!.contains(key),
              enableDropToResize: true,
              enableContextMenu: false,
              width: Utils.getColumnSize(
                key: key,
                value: mapData[0][key].toString(),
              ),
              enableAutoEditing: false,
              hide: showonly == null
                  ? (hideKeys != null && hideKeys!.contains(key)) ||
                      hideCode! &&
                          key.toString().toLowerCase() != "hourcode" &&
                          key.toString().toLowerCase().contains("code")
                  : !showonly!.contains(key),
              enableColumnDrag: false,
              field: key,
              type: PlutoColumnType.text()));
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : key.toString().pascalCaseToNormal()
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: canShowFilter
                        ? (detail) {
                            if (onContextMenuClick == null) {
                              DataGridMenu().showGridMenu(
                                  rendererContext.stateManager, detail, context,
                                  exportFileName: exportFileName,
                                  csvFormat: csvFormat ?? false,
                                  data: mapData,
                                  removeKeysFromFile: removeKeysFromFile);
                            } else {
                              DataGridMenu().showGridCustomMenu(
                                  rendererContext.stateManager, detail, context,
                                  exportFileName: exportFileName,
                                  onPressedClick: onContextMenuClick,
                                  data: mapData,
                                  plutoContext: rendererContext);
                            }
                          }
                        : null,
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else if (showOnlyCheckBox == true) {
                return GestureDetector(
                  onSecondaryTapDown: canShowFilter
                      ? (detail) {
                          if (onContextMenuClick == null) {
                            DataGridMenu().showGridMenu(
                                rendererContext.stateManager, detail, context,
                                exportFileName: exportFileName,
                                csvFormat: csvFormat ?? false,
                                data: mapData,
                                removeKeysFromFile: removeKeysFromFile);
                          } else {
                            DataGridMenu().showGridCustomMenu(
                                rendererContext.stateManager, detail, context,
                                exportFileName: exportFileName,
                                onPressedClick: onContextMenuClick,
                                data: mapData,
                                plutoContext: rendererContext);
                          }
                        }
                      : null,
                  child: ((key ?? "").toString().toLowerCase().trim() ==
                          (checkRowKey ?? "").toString().toLowerCase().trim())
                      ? Checkbox(
                          value: (rendererContext.cell.value != null &&
                                  (rendererContext.cell.value)
                                          .toString()
                                          .trim() ==
                                      "true")
                              ? true
                              : false,
                          onChanged: (bool? value) {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        )
                      : Text(
                          rendererContext.cell.value.toString(),
                          style: TextStyle(
                            fontSize: SizeDefine.columnTitleFontSize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: canShowFilter
                      ? (detail) {
                          if (onContextMenuClick == null) {
                            DataGridMenu().showGridMenu(
                                rendererContext.stateManager, detail, context,
                                exportFileName: exportFileName,
                                csvFormat: csvFormat ?? false,
                                data: mapData,
                                removeKeysFromFile: removeKeysFromFile);
                          } else {
                            DataGridMenu().showGridCustomMenu(
                                rendererContext.stateManager, detail, context,
                                exportFileName: exportFileName,
                                onPressedClick: onContextMenuClick,
                                data: mapData,
                                plutoContext: rendererContext);
                          }
                        }
                      : null,
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (witdthSpecificColumn != null &&
                    witdthSpecificColumn!.keys.toList().contains(key))
                ? witdthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" || element.value == null
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows" + e.toString());
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
              focusNode: focusNode!,
              autoScale: columnAutoResize,
              actionOnPress: actionOnPress,
              actionKey: actionIconKey,
              previousWidgetFN: previousWidgetFN,
              rowHeight: 25,
            ),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              // load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
              //     autoSizeMode: columnAutoResize
              //         ? PlutoAutoSizeMode.none
              //         : PlutoAutoSizeMode.scale,
              //     resizeMode: PlutoResizeMode.normal));
              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            onRowChecked: onRowCheck,
            rows: segRows),
      ),
    );
  }
}

Color getColors(PlutoColumnRendererContext plutoCon) {
  Color color = Colors.white;
  print(">>>>>>>>>>>>>>>>>>>keyGet" + plutoCon.cell.column.title.toString());
  try {
    if (plutoCon.cell.column.title.toString().trim().toLowerCase() !=
        "Parentid".toLowerCase()) {
      List<String>? data = plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['parentid']?.value
          .toString()
          .split("-");
      // print(">>>>>>>>>splitList$data");
      if (plutoCon.stateManager.currentCell == plutoCon.cell) {
        color = Colors.deepPurple.shade200;
      } else if (data != null && data.isEmpty) {
        color = Colors.white;
      } else if (plutoCon.cell.value == null ||
          plutoCon.cell.value.toString().trim() == "null" ||
          plutoCon.cell.value.toString().trim() == "") {
        color = Colors.pink;
      } else if (double.parse((plutoCon.cell.value ?? "0").toString()) <
          double.parse(data![1] ?? "0")) {
        color = Colors.lightBlue;
      }
    } else if (plutoCon.stateManager.currentCell == plutoCon.cell) {
      color = Colors.deepPurple.shade200;
    } else {
      color = Colors.white;
    }
  } catch (e) {
    if (plutoCon.stateManager.currentCell == plutoCon.cell) {
      color = Colors.deepPurple.shade200;
    } else {
      color = Colors.white;
    }
  }

  return color;
}

FontWeight getChannelFont(PlutoColumnRendererContext plutoCon) {
  FontWeight font = FontWeight.normal;
  plutoCon.stateManager.resetShowFrozenColumn();
  List<PlutoColumn> listOfHideColumn = [];
  // print(">>>>>>>>>>>>>>>DataValueCell${plutoCon.cell.value}");
  for (var element in plutoCon.stateManager.columns) {
    // print(">>>>>>>>>>>>>>>>>>>keyGetJKs${element.title} ${element.key}");
    if (element.title.toString().trim() == "Unallocated Spots Is Bold" ||
        // element.title.toString().trim() == "${element.title.toString().trim()} Is Bold" ||
        element.title.toString().trim() == "Total Spots Is Bold" ||
        element.title.toString().trim() == "Locationname Is Bold" ||
        element.title.toString().trim() == "Channelname Is Bold") {
      listOfHideColumn.add(element);
    }
  }

  /* for (var element in plutoCon.stateManager.rows) {
    print(">>>>>>>>>>>>>elementData"+(element.toJson()).toString());
  }*/

  if (plutoCon
          .stateManager
          .rows[plutoCon.rowIdx]
          .cells[("${(plutoCon.column.field ?? "").toString().trim()}IsBold")]
          ?.value
          .toString()
          .trim() ==
      "true") {
    font = FontWeight.bold;
  }
  if (listOfHideColumn.isNotEmpty) {
    plutoCon.stateManager.hideColumns(listOfHideColumn, true);
  }
  return font;
}

FontWeight getMasterFont(PlutoColumnRendererContext plutoCon) {
  FontWeight font = FontWeight.normal;
  plutoCon.stateManager.resetShowFrozenColumn();
  List<PlutoColumn> listOfHideColumn = [];
  for (var element in plutoCon.stateManager.columns) {
    if (element.title.toString().trim() == "Booking Number Is Bold") {
      // print(">>>>>>>>>>>>>>element.title.toString().trim()${element.title.toString().trim()}");
      listOfHideColumn.add(element);
    }
  }
/*  for (var element in plutoCon.stateManager.rows) {
    print(">>>>>>>>>>>>>elementData"+(element.cells['bookingNumberIsBold']?.value).toString());
  }
  if (plutoCon
          .stateManager
          .rows[plutoCon.rowIdx]
          .cells[("${(plutoCon.column.field ?? "").toString().trim()}IsBold")]
          ?.value
          .toString()
          .trim() ==
      "true") {
    font = FontWeight.bold;
  }*/
  if (plutoCon.column.field.toString().trim() == "bookingNumber") {
    font = FontWeight.bold;
  }
  if (listOfHideColumn.isNotEmpty) {
    plutoCon.stateManager.hideColumns(listOfHideColumn, true);
  }
  return font;
}

FontWeight getLocalFont(PlutoColumnRendererContext plutoCon) {
  FontWeight font = FontWeight.normal;
  plutoCon.stateManager.resetShowFrozenColumn();
  List<PlutoColumn> listOfHideColumn = [];
  for (var element in plutoCon.stateManager.columns) {
    if (element.title.toString().trim() == "Booking Number Is Bold") {
      listOfHideColumn.add(element);
    }
  }

  if (plutoCon
          .stateManager
          .rows[plutoCon.rowIdx]
          .cells[("${(plutoCon.column.field ?? "").toString().trim()}IsBold")]
          ?.value
          .toString()
          .trim() ==
      "true") {
    font = FontWeight.bold;
  }
  if (listOfHideColumn.isNotEmpty) {
    plutoCon.stateManager.hideColumns(listOfHideColumn, true);
  }
  return font;
}

String getKey(String? text) {
  if (text == "") {
    return "";
  } else {
    return "";
  }
}
