import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:intl/intl.dart' as df;

class AppDataGridWidget extends StatefulWidget {
  final List<dynamic> list;
  final bool autoFitAfterLoad;
  final bool enableColumnDrag;
  final bool enableRowDrag;
  final List<String>? singleCheckBoxColumnName, editingColumnName;
  final String dateFormat;
  const AppDataGridWidget({
    super.key,
    required this.list,
    this.autoFitAfterLoad = false,
    this.enableColumnDrag = false,
    this.enableRowDrag = false,
    this.singleCheckBoxColumnName,
    this.editingColumnName,
    this.dateFormat = "dd-MM-yyyy",
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
                if (widget.autoFitAfterLoad) {
                  for (var i = 0; i < event.stateManager.columns.length; i++) {
                    event.stateManager.autoFitColumn(context, event.stateManager.columns[i]);
                  }
                }
              },
              configuration: const PlutoGridConfiguration().copyWith(
                tabKeyAction: PlutoGridTabKeyAction.moveToNextOnEdge,
                // shortcut: PlutoGridShortcut(
                //   actions: {},
                // ),
                scrollbar: const PlutoGridScrollbarConfig(
                  draggableScrollbar: true,
                  isAlwaysShown: true,
                  hoverWidth: 15,
                ),
                columnSize: const PlutoGridColumnSizeConfig().copyWith(autoSizeMode: PlutoAutoSizeMode.scale, resizeMode: PlutoResizeMode.normal),
                style: PlutoGridStyleConfig(
                  columnContextIcon: Icons.swap_horiz_outlined,
                  columnHeight: 40,
                  defaultColumnTitlePadding: const EdgeInsets.all(8),
                  columnTextStyle: textStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  gridBorderRadius: BorderRadius.circular(12),
                  inactivatedBorderColor: Colors.grey,
                  activatedBorderColor: Colors.deepPurple,
                  enableCellBorderVertical: false,
                  cellTextStyle: textStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 12),
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

  bool notNullAndEmpty(dynamic val) {
    return (val != null && val.isNotEmpty);
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
