import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';

import '../controllers/monthly_report_controller.dart';

class MonthlyReportView extends GetView<MonthlyReportController> {
  const MonthlyReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Controllers
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10,
                runSpacing: 10,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      controller.handleOnChangedLocation,
                      "Location",
                      .2,
                      autoFocus: true,
                      selected: controller.selectedLocation,
                      inkWellFocusNode: controller.locationFN,
                      isEnable: controller.bottomControllsEnable.value,
                    );
                  }),
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.channelList.value,
                      (v) => controller.selectedChannel = v,
                      "Channel",
                      .2,
                      selected: controller.selectedChannel,
                      isEnable: controller.bottomControllsEnable.value,
                    );
                  }),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.effectiveDateTC,
                    widthRation: 0.15,
                    onFocusChange: (date) {
                      controller.weekDaysTC.text = DateFormat('EEEE').format(DateFormat("dd-MM-yyyy").parse(date));
                    },
                    isEnable: controller.bottomControllsEnable.value,
                    startDate: DateTime.now(),
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controller.effectiveDateTC,
                    widthRation: 0.15,
                    onFocusChange: (date) {
                      controller.weekDaysTC.text = DateFormat('EEEE').format(DateFormat("dd-MM-yyyy").parse(date));
                    },
                    isEnable: controller.bottomControllsEnable.value,
                    startDate: DateTime.now(),
                  ),
                  Obx(() {
                    return RadioRow(
                      items: const ["Default", "Add", "Fixed"],
                      groupValue: controller.selectedRadio.value,
                      onchange: (val) => controller.selectedRadio.value = val,
                    );
                  }),
                  FormButton(btnText: "Generate", callback: controller.handleGenerateButton)
                ],
              ),

              ///Data table
              Expanded(
                child: Obx(
                  () {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: controller.dataTableList.value.isEmpty
                          ? BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            )
                          : null,
                      child: controller.dataTableList.value.isEmpty
                          ? null
                          : DataGridFromMap(
                              mapData: controller.dataTableList.value.map((e) => e.toJson()).toList(),
                              editKeys: ["commDuration"],
                              onEdit: (row) {
                                controller.lastSelectedIdx = row.rowIdx;
                                if (RegExp(r'^[0-9]+$').hasMatch(row.value)) {
                                  controller.dataTableList[row.rowIdx].commDuration = num.tryParse(row.value.toString());
                                  controller.madeChanges = true;
                                } else {
                                  controller.dataTableList.refresh();
                                }
                              },
                              // witdthSpecificColumn: {
                              //   "commDuration": 200,
                              // },
                              mode: PlutoGridMode.normal,
                              colorCallback: (row) =>
                                  (row.row.cells.containsValue(controller.stateManager?.currentCell)) ? Colors.deepPurple.shade200 : Colors.white,
                              onload: (event) {
                                controller.stateManager = event.stateManager;
                                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                                event.stateManager.setSelecting(true);
                                event.stateManager.setCurrentCell(
                                    event.stateManager.getRowByIdx(controller.lastSelectedIdx)?.cells['commDuration'], controller.lastSelectedIdx);
                              },
                            ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormButton(btnText: "Clear"),
                    const SizedBox(width: 10),
                    FormButton(btnText: "Exit"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
