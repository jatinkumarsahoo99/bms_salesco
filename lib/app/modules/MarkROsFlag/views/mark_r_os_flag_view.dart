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
import '../controllers/mark_r_os_flag_controller.dart';

class MarkROsFlagView extends GetView<MarkROsFlagController> {
  const MarkROsFlagView({Key? key}) : super(key: key);
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
                          : DataGridFromMap3(
                              mapData: controller.dataTableList.value.map((e) => e.toJson()).toList(),
                              checkBoxColumnKey: ['flag'],
                              checkBoxStrComparison: "true",
                              uncheckCheckBoxStr: "false",
                              actionIconKey: ['flag'],
                              actionOnPress: (position, isSpaceCalled) {
                                if (isSpaceCalled) {
                                  controller.lastSelectedIdx = position.rowIdx ?? 0;
                                  controller.stateManager!.changeCellValue(
                                    controller.stateManager!.currentCell!,
                                    controller.stateManager!.currentCell!.value == "true" ? "false" : "true",
                                    force: true,
                                    callOnChangedEvent: true,
                                    notify: true,
                                  );
                                }
                              },
                              onEdit: (row) {
                                controller.lastSelectedIdx = row.rowIdx;
                                controller.madeChanges = true;
                                controller.dataTableList[row.rowIdx].flag = row.value == "true";
                              },
                              mode: PlutoGridMode.normal,
                              colorCallback: (row) =>
                                  (row.row.cells.containsValue(controller.stateManager?.currentCell)) ? Colors.deepPurple.shade200 : Colors.white,
                              onload: (event) {
                                controller.stateManager = event.stateManager;
                                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                                event.stateManager.setSelecting(true);
                                event.stateManager.setCurrentCell(
                                    event.stateManager.getRowByIdx(controller.lastSelectedIdx)?.cells['telecastDate'], controller.lastSelectedIdx);
                              },
                        widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                            userGridSettingList: controller.userGridSetting1?.value),),
                    );
                  },
                ),
              ),

              ///bottom controlls buttons
              Obx(() {
                return Row(
                  children: List.generate(
                    controller.buttonsList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(left: index != 0 ? 10 : 0),
                      child: FormButton(
                        btnText: controller.buttonsList[index],
                        callback: controller.bottomControllsEnable.value
                            ? () => controller.saveTodayAndAllData(controller.buttonsList[index] == "Save Today")
                            : null,
                      ),
                    ),
                  ).toList(),
                );
              }),
              SizedBox(height: 10),

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
