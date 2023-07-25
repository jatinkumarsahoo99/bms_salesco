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

import '../controllers/auto_time_lock_controller.dart';

class AutoTimeLockView extends GetView<AutoTimeLockController> {
  const AutoTimeLockView({Key? key}) : super(key: key);
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

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              // InputFields.numbers(
              //   hintTxt: "Common.Dur.Sec For 30 Mins Prog.",
              //   inputformatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //   ],
              //   controller: controller.counterTC,
              //   padLeft: 5,
              //   isNegativeReq: false,
              //   width: .17,
              // ),
              // SizedBox(
              //   width: context.width * .17,
              //   child: Obx(() {
              //     return NumericStepButton(
              //       counter: controller.count.value,
              //       onChanged: (val) {
              //         controller.count.value = val;
              //       },
              //       hint: "Common.Dur.Sec For 30 Mins Prog.",
              //       isEnable: controller.bottomControllsEnable.value,
              //     );
              //   }),
              // ),
              // const SizedBox(width: 10),
              //     ],
              //   ),
              // ),

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
