import 'package:bms_salesco/widgets/CheckBoxWidget.dart';
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
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/make_good_report_controller.dart';

class MakeGoodReportView extends GetView<MakeGoodReportController> {
  const MakeGoodReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ///Controllers
              Wrap(
                // crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 10,
                runSpacing: 10,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      controller.handleOnChangedLocation,
                      "Location",
                      .3,
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
                      .3,
                      selected: controller.selectedChannel,
                      isEnable: controller.bottomControllsEnable.value,
                    );
                  }),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.effectiveDateTC,
                    widthRation: 0.15,
                    isEnable: controller.bottomControllsEnable.value,
                    startDate: DateTime.now(),
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controller.effectiveDateTC,
                    widthRation: 0.15,
                    isEnable: controller.bottomControllsEnable.value,
                    startDate: DateTime.now(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropDownField.formDropDown1WidthMap(
                        controller.channelList.value,
                        (v) => controller.selectedChannel = v,
                        "Client",
                        .83,
                        selected: controller.selectedChannel,
                        isEnable: controller.bottomControllsEnable.value,
                      ),
                      SizedBox(width: 10),
                      CheckBoxWidget1(title: "All Clients")
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropDownField.formDropDown1WidthMap(
                        controller.channelList.value,
                        (v) => controller.selectedChannel = v,
                        "Agency",
                        .3,
                        selected: controller.selectedChannel,
                        isEnable: controller.bottomControllsEnable.value,
                      ),
                      SizedBox(width: 10),
                      DropDownField.formDropDown1WidthMap(
                        controller.channelList.value,
                        (v) => controller.selectedChannel = v,
                        "Brand",
                        .3,
                        selected: controller.selectedChannel,
                        isEnable: controller.bottomControllsEnable.value,
                      ),
                      SizedBox(width: 10),
                      FormButton(btnText: "Report", callback: controller.handleGenerateButton),
                    ],
                  ),
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

              ///Common Buttons
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (btncontroller) {
                      if (btncontroller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in btncontroller.buttons!) ...{
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                    ? null
                                    : () => controller.formHandler(btn['name']),
                              )
                            },
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
