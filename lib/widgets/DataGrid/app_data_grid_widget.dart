import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AppDataGridWidget extends StatefulWidget {
  final List<dynamic> list;
  const AppDataGridWidget({
    super.key,
    required this.list,
  });

  @override
  State<AppDataGridWidget> createState() => _AppDataGridWidgetState();
}

class _AppDataGridWidgetState extends State<AppDataGridWidget> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
              // rowColorCallback: (rowColorContext) {
              //   return Colors.green.shade100;
              // },
              configuration: PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  columnHeight: 40,
                  defaultColumnTitlePadding: EdgeInsets.all(8),
                  columnTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                  gridBorderRadius: BorderRadius.circular(12),
                  borderColor: Colors.transparent,
                  inactivatedBorderColor: Colors.grey,
                  activatedBorderColor: Colors.red,
                  gridBorderColor: Colors.transparent,
                  cellTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 13),
                  defaultCellPadding: EdgeInsets.all(4),
                  rowHeight: 30,
                  activatedColor: Colors.deepPurpleAccent.shade100,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool> bindDataWithGrid() async {
    try {
      columns = [];
      rows = [];
      for (var element in (widget.list.first as Map).entries) {
        columns.add(
          PlutoColumn(
            title: element.key,
            field: element.key,
            type: PlutoColumnType.text(),
          ),
        );
      }

      for (var i = 0; i < widget.list.length; i++) {
        Map<String, PlutoCell> cells = {};
        for (var element in (widget.list[i] as Map).entries) {
          cells[element.key] = PlutoCell(value: element.value);
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
