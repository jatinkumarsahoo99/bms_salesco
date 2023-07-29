import 'package:bms_salesco/widgets/CheckBoxWidget.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
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
                              onRowDoubleTap: (val) {
                                controller.lastSelectedIdx = val.rowIdx;
                                controller.stateManager?.setCurrentCell(
                                    controller.stateManager?.getRowByIdx(controller.lastSelectedIdx)?.cells['channelName'],
                                    controller.lastSelectedIdx);

                                var temp = controller.dataTableList[val.rowIdx];
                                var resCanLockTC = TextEditingController(text: temp.resCanLockTime);
                                var nextDayLockTC = TextEditingController(text: temp.nextDayLockTime);
                                Get.defaultDialog(
                                  title: "Edit",
                                  content: SizedBox(
                                    width: context.width * .6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InputFields.formFieldDisable(
                                          hintTxt: "Channel",
                                          value: temp.channelName ?? "",
                                          widthRatio: .3,
                                        ),
                                        InputFields.numbers(
                                          hintTxt: "Same Day Close",
                                          controller: TextEditingController(text: (temp.sameDayClose ?? "0").toString()),
                                          onchanged: (v) {
                                            temp.sameDayClose = int.tryParse(v) ?? 0;
                                          },
                                          width: .3,
                                        ),
                                        InputFields.formFieldNumberMask(
                                          hintTxt: "Res Can Lock Time",
                                          paddingLeft: 0,
                                          controller: resCanLockTC,
                                          widthRatio: .3,
                                          isTime: true,
                                        ),
                                        InputFields.numbers(
                                          hintTxt: "FPC Lock Days",
                                          controller: TextEditingController(text: (temp.fpcLockDays ?? "0").toString()),
                                          onchanged: (v) {
                                            temp.fpcLockDays = int.tryParse(v) ?? 0;
                                          },
                                          width: .3,
                                        ),
                                        InputFields.numbers(
                                          hintTxt: "Excess Book",
                                          controller: TextEditingController(text: (temp.excessBooking ?? "0").toString()),
                                          onchanged: (v) {
                                            temp.excessBooking = int.tryParse(v) ?? 0;
                                          },
                                          width: .3,
                                        ),
                                        InputFields.formFieldNumberMask(
                                          hintTxt: "Next Day Lock Time",
                                          paddingLeft: 0,
                                          controller: nextDayLockTC,
                                          widthRatio: .3,
                                          isTime: true,
                                        ),
                                        CheckBoxWidget1(
                                          title: "Channel Lock Y N",
                                          value: (temp.channelLockYN ?? "N") == "Y",
                                          onChanged: (val) {
                                            temp.channelLockYN = (val ?? false) ? "Y" : "N";
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  confirm: FormButton(
                                    btnText: "Cancel",
                                    callback: () {
                                      Get.back();
                                    },
                                  ),
                                  cancel: FormButton(
                                    btnText: "Ok",
                                    callback: () {
                                      temp.resCanLockTime = resCanLockTC.text;
                                      temp.nextDayLockTime = nextDayLockTC.text;
                                      controller.dataTableList[val.rowIdx] = temp;
                                      controller.dataTableList.refresh();
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                              mode: PlutoGridMode.normal,
                              colorCallback: (row) =>
                                  (row.row.cells.containsValue(controller.stateManager?.currentCell)) ? Colors.deepPurple.shade200 : Colors.white,
                              onload: (event) {
                                event.stateManager.gridFocusNode.requestFocus();
                                controller.stateManager = event.stateManager;
                                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                                event.stateManager.setSelecting(true);
                                event.stateManager.moveCurrentCellByRowIdx(controller.lastSelectedIdx, PlutoMoveDirection.down);
                                event.stateManager.setCurrentCell(
                                    event.stateManager.getRowByIdx(controller.lastSelectedIdx)?.cells['channelName'], controller.lastSelectedIdx);
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
