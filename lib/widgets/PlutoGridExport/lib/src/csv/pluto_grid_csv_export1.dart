import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';
import 'package:csv/csv.dart';

import '../abstract_text_export.dart';

/// Csv exporter for PlutoGrid
class PlutoGridDefaultCsvExport1 extends AbstractTextExport<String> {
  const PlutoGridDefaultCsvExport1({
    this.fieldDelimiter,
    this.textDelimiter,
    this.textEndDelimiter,
    this.eol,
  }) : super();

  final String? fieldDelimiter;
  final String? textDelimiter;
  final String? textEndDelimiter;
  final String? eol;

  /// [state] PlutoGrid's PlutoGridStateManager.
  @override
  String export(PlutoGridStateManager state) {
    String toCsv = const ListToCsvConverter().convert(
      [
        getColumnTitles1(state),
        ...mapStateToListOfRows1(state),
      ],
      fieldDelimiter: fieldDelimiter,
      textDelimiter: textDelimiter,
      textEndDelimiter: textEndDelimiter,
      delimitAllFields: true,
      eol: eol,
    );

    return toCsv;
  }
}
