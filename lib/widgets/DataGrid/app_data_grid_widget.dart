import 'package:bms_salesco/app/providers/extensions/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:intl/intl.dart' as df;

import '../../app/providers/SizeDefine.dart';

class AppDataGridWidget extends StatefulWidget {
  final List<dynamic> list;
  final bool autoFitAfterLoad;
  final bool enableColumnDrag;
  final bool enableRowDrag;
  final List<String>? singleCheckBoxColumnName, editingColumnName;
  final String dateFormat;
  final PlutoAutoSizeMode? autoSizeMode;
  // final FocusNode? focusNode;
  const AppDataGridWidget({
    super.key,
    required this.list,
    this.autoFitAfterLoad = false,
    this.enableColumnDrag = false,
    this.enableRowDrag = false,
    // this.focusNode,
    this.singleCheckBoxColumnName,
    this.editingColumnName,
    this.dateFormat = "dd-MM-yyyy",
    this.autoSizeMode,
  });

  @override
  State<AppDataGridWidget> createState() => _AppDataGridWidgetState();
}

class _AppDataGridWidgetState extends State<AppDataGridWidget> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;
  late TextStyle textStyle;
  @override
  void initState() {
    textStyle = GoogleFonts.poppins(color: Colors.black);
    super.initState();
  }

  PlutoGridStateManager? gridSM;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FutureBuilder<bool>(
        initialData: true,
        future: bindDataWithGrid(),
        builder: (context, snapShot) {
          if (snapShot.data!) {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if ((snapShot.data!) && widget.list.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
            );
          } else {
            return PlutoGrid(
              columns: columns,
              rows: rows,
              onRowSecondaryTap: (event) {
                debugPrint("onRowSecondaryTap Called");
              },
              onSelected: (event) {
                debugPrint("onSelected");
              },
              onRowDoubleTap: (event) {
                debugPrint("onRowDoubleTap");
              },
              onRowChecked: (event) {
                debugPrint("onRowChecked");
              },
              onLoaded: (event) {
                gridSM = event.stateManager;
                if (widget.autoFitAfterLoad) {
                  for (var i = 0; i < event.stateManager.columns.length; i++) {
                    event.stateManager.autoFitColumn(context, event.stateManager.columns[i]);
                  }
                }
              },
              configuration: const PlutoGridConfiguration().copyWith(
                tabKeyAction: PlutoGridTabKeyAction.moveToNextOnEdge,
                shortcut: PlutoGridShortcut(
                  actions: {
                    ...PlutoGridShortcut.defaultActions,
                    LogicalKeySet(LogicalKeyboardKey.tab): AppDataGridCustomAction(true, context),
                    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.tab): AppDataGridCustomAction(false, context),
                  },
                ),
                scrollbar: const PlutoGridScrollbarConfig(
                  draggableScrollbar: true,
                  isAlwaysShown: true,
                  hoverWidth: 15,
                ),
                enterKeyAction: PlutoGridEnterKeyAction.none,
                columnSize: const PlutoGridColumnSizeConfig()
                    .copyWith(autoSizeMode: widget.autoSizeMode ?? PlutoAutoSizeMode.scale, resizeMode: PlutoResizeMode.normal),
                style: PlutoGridStyleConfig(
                  columnContextIcon: Icons.swap_horiz_outlined,
                  columnHeight: 40,
                  defaultColumnTitlePadding: const EdgeInsets.all(8),
                  columnTextStyle: textStyle.copyWith(fontWeight: FontWeight.w600, fontSize: SizeDefine2.componentTitle),
                  gridBorderRadius: BorderRadius.circular(12),
                  inactivatedBorderColor: Colors.grey,
                  activatedBorderColor: Colors.deepPurple,
                  enableCellBorderVertical: false,
                  cellTextStyle: textStyle.copyWith(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentTitle),
                  defaultCellPadding: const EdgeInsets.all(4),
                  rowHeight: 30,
                  activatedColor: Colors.deepPurple.shade100,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  double getStringWidth(String text, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }

  Future<bool> bindDataWithGrid() async {
    try {
      columns = [];
      rows = [];

      /// adding columns
      for (var element in (widget.list.first as Map).entries) {
        columns.add(
          PlutoColumn(
            title: element.key,
            field: element.key,
            minWidth: 0,
            
            enableRowChecked: widget.singleCheckBoxColumnName != null && widget.singleCheckBoxColumnName!.contains(element.key),
            enableEditingMode: widget.editingColumnName != null && widget.editingColumnName!.contains(element.key),
            enableAutoEditing: widget.editingColumnName != null && widget.editingColumnName!.contains(element.key),
            applyFormatterInEditing: widget.editingColumnName != null && widget.editingColumnName!.contains(element.key),
            type: widget.singleCheckBoxColumnName != null && widget.singleCheckBoxColumnName!.contains(element.key)
                ? PlutoColumnType.select(
                    [],
                    defaultValue: false,
                    enableColumnFilter: true,
                  )
                : PlutoColumnType.text(),
            enableColumnDrag: widget.enableColumnDrag,
            enableRowDrag: widget.enableRowDrag,
          ),
        );
      }

      /// adding rows
      for (var i = 0; i < widget.list.length; i++) {
        Map<String, PlutoCell> cells = {};
        for (var element in (widget.list[i] as Map).entries) {
          if (element.value.toString().toLowerCase().contains("date")) {
            cells[element.key] = PlutoCell(value: df.DateFormat(widget.dateFormat).parse(element.value).toString());
          } else {
            cells[element.key] = PlutoCell(value: element.value);
          }
        }
        rows.add(
          PlutoRow(cells: cells, sortIdx: i),
        );
      }
    } catch (e) {
      print("Error while adding rows and columns in datatable ERROR:$e");
    }
    return false;
  }
}

class AppDataGridCustomAction extends PlutoGridShortcutAction {
  final bool fromTab;
  final BuildContext context;
  AppDataGridCustomAction(this.fromTab, this.context);
  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    if (fromTab) {
      // tab
      if (stateManager.currentCell?.row == stateManager.refRows.last && stateManager.currentCell?.column == stateManager.refColumns.last) {
        FocusScope.of(context).nextFocus();
      } else {
        if (stateManager.currentCell == null) {
          stateManager.setCurrentCell(stateManager.firstCell, 0);
        } else {
          stateManager.moveCellNext();
        }
      }
    } else {
      if ((stateManager.currentRowIdx == 0 && stateManager.currentCellPosition?.columnIdx == 0)) {
        // Shift + tab
        // FocusScope.of(context).nearestScope.previousFocus();
        // stateManager.gridFocusNode.unfocus();
        // stateManager.setCurrentCellPosition(null);
        // stateManager.setKeepFocus(false);
        // Future.delayed(Duration(seconds: 3)).then((value) {
        //   FocusScope.of(context).previousFocus();
        //   stateManager.gridFocusNode.previousFocus();
        // });
      } else {
        stateManager.moveCellPrevious();
      }
    }
  }
}
