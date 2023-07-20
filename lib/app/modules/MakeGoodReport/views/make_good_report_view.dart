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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  const SizedBox(width: 10),
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
                  const SizedBox(width: 10),
                  Obx(() {
                    return DateWithThreeTextField(
                      title: "Effective Date",
                      mainTextController: controller.effectiveDateTC,
                      widthRation: 0.15,
                      onFocusChange: (date) {
                        controller.weekDaysTC.text = DateFormat('EEEE').format(DateFormat("dd-MM-yyyy").parse(date));
                      },
                      isEnable: controller.bottomControllsEnable.value,
                      startDate: DateTime.now(),
                    );
                  }),
                  const SizedBox(width: 10),
                  InputFields.formField1(
                    hintTxt: "Weekday",
                    controller: controller.weekDaysTC,
                    isEnable: false,
                  ),
                  const SizedBox(width: 10),
                  FormButton(btnText: "Display", callback: controller.handleGenerateButton)
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

              ///bottom controlls buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputFields.numbers(
                      hintTxt: "Common.Dur.Sec For 30 Mins Prog.",
                      inputformatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: controller.counterTC,
                      padLeft: 5,
                      isNegativeReq: false,
                      width: .17,
                    ),
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
                    Obx(() {
                      return Row(
                        children: List.generate(
                          controller.buttonsList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: FormButton(
                              btnText: controller.buttonsList[index],
                              callback: controller.bottomControllsEnable.value
                                  ? () => controller.handleBottonButtonsTap(controller.buttonsList[index])
                                  : null,
                            ),
                          ),
                        ).toList(),
                      );
                    }),
                  ],
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
