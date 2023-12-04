import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/same_day_collection_controller.dart';

class SameDayCollectionView extends GetView<SameDayCollectionController> {
  const SameDayCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      controller.handleOnChangedLocation,
                      "Location",
                      .15,
                      autoFocus: true,
                      selected: controller.selectedLocation,
                      inkWellFocusNode: controller.locationFN,
                      isEnable: controller.isControllsEnable.value,
                    );
                  }),
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.channelList.value,
                      (val) => controller.selectedChannel = val,
                      "Channel",
                      .15,
                      selected: controller.selectedChannel,
                      isEnable: controller.isControllsEnable.value,
                    );
                  }),
                  Obx(() {
                    return DateWithThreeTextField(
                      title: "From",
                      mainTextController: controller.fromTC,
                      isEnable: controller.isControllsEnable.value,
                    );
                  }),
                  Obx(() {
                    return FormButton(
                      btnText: "Show",
                      isEnabled: controller.isControllsEnable.value,
                      callback: controller.showData,
                    );
                  }),
                  Obx(() {
                    return FormButton(
                      btnText: !controller.checkedAll.value
                          ? "Check All"
                          : "Clear All",
                      callback: controller.handleCheckAndUncheck,
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: controller.dataTableList.isEmpty
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    child: controller.dataTableList.isEmpty
                        ? null
                        : DataGridFromMap3(
                            hideCode: false,
                            mode: PlutoGridMode.selectWithOneTap,
                            checkBoxColumnKey: ["cancel"],
                            actionIconKey: ['cancel'],
                            specificWidth: {
                              "clientname": 200,
                            },
                            onload: (event) {
                              controller.manager = event.stateManager;
                              event.stateManager
                                  .setSelectingMode(PlutoGridSelectingMode.row);
                              event.stateManager.setSelecting(true);
                              event.stateManager.moveScrollByRow(
                                  PlutoMoveDirection.down,
                                  controller.lastSelctedIdx);
                              event.stateManager.setCurrentCell(
                                event.stateManager
                                    .getRowByIdx(controller.lastSelctedIdx)
                                    ?.cells['isActive'],
                                controller.lastSelctedIdx,
                              );
                            },
                            actionOnPress: (position, isSpaceCalled) {
                              if (isSpaceCalled) {
                                controller.lastSelctedIdx =
                                    position.rowIdx ?? 0;
                                controller.manager!.changeCellValue(
                                  controller.manager!.currentCell!,
                                  controller.manager!.currentCell!.value ==
                                          "true"
                                      ? "false"
                                      : "true",
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                              }
                            },
                            colorCallback: (row) => (row.row.cells
                                    .containsValue(
                                        controller.manager?.currentCell))
                                ? Colors.deepPurple.shade200
                                : Colors.white,
                            onEdit: (event) {
                              controller.lastSelctedIdx = event.rowIdx;
                              controller.dataTableList[event.rowIdx].cancel =
                                  (event.value == "true");
                            },
                            widthSpecificColumn: Get.find<HomeController>()
                                .getGridWidthByKey(
                                    userGridSettingList:
                                        controller.userGridSetting1),
                            uncheckCheckBoxStr: "false",
                            checkBoxStrComparison: "true",
                            mapData: controller.dataTableList.value
                                .map((e) => e.toJson())
                                .toList(),
                            columnAutoResize: false,
                          ),
                  );
                },
              ),
            ),

            /// bottom common buttons
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (btncontroller) {
                    if (btncontroller.buttons != null) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: SizedBox(
                          height: 40,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 15,
                            alignment: WrapAlignment.center,
                            children: [
                              for (var btn in btncontroller.buttons!) ...{
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback: ((Utils.btnAccessHandler(
                                              btn['name'],
                                              controller.formPermissions!) ==
                                          null))
                                      ? null
                                      : () =>
                                          controller.formHandler(btn['name']),
                                )
                              },
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
