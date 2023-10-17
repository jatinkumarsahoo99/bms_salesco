import 'dart:html';

import 'package:bms_salesco/widgets/gridFromMap1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/tape_i_d_campaign_controller.dart';

class TapeIDCampaignView extends GetView<TapeIDCampaignController> {
  const TapeIDCampaignView({Key? key}) : super(key: key);

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
              GetBuilder(
                init: controller,
                id: controller.selectedValuUI,
                builder: (_) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      InputFields.formField1(
                          hintTxt: "Enter Tape ID",
                          controller: controller.tapeIDTC,
                          width: .15,
                          autoFocus: true,
                          padLeft: 0,
                          focusNode: controller.tapeIdFN,
                          inputformatters: [
                            UpperCaseTextFormatter(),
                          ]),
                      InputFields.formFieldDisable1(
                          hintTxt: "Activity Month",
                          value: controller.activityMonth,
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Client",
                          value:
                              controller.loadModel?.tapeIdDetails.clientName ??
                                  "",
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Agency",
                          value:
                              controller.loadModel?.tapeIdDetails.agencyName ??
                                  "",
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Brand",
                          value:
                              controller.loadModel?.tapeIdDetails.brandName ??
                                  "",
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Caption",
                          value: controller
                                  .loadModel?.tapeIdDetails.commercialCaption ??
                              "",
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Duration",
                          value: controller
                                  .loadModel?.tapeIdDetails.commercialDuration
                                  .toString() ??
                              "",
                          widthRatio: .15,
                          leftPad: 0),
                      InputFields.formFieldDisable1(
                          hintTxt: "Agency Tape ID",
                          value: controller
                                  .loadModel?.tapeIdDetails.agencytapeid ??
                              "",
                          widthRatio: .15,
                          leftPad: 0),
                      DateWithThreeTextField(
                        title: "Start Date",
                        mainTextController: controller.startDateTC,
                        widthRation: .15,
                        onFocusChange: (h) {
                          var tempDate = DateFormat("dd-MM-yyyy").parse(h);
                          controller.startDate = tempDate
                              .subtract(Duration(days: (tempDate.day) - 1));

                          controller.endDate = DateTime(
                            controller.startDate.year,
                            controller.startDate.month + 1,
                            0,
                          );
                          print(controller.startDate.toString());
                          print(controller.endDate.toString());
                          // controller.endDateTC.text = h;
                          controller.update(['toDate']);
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            controller.endDateTC.text = h;
                          });
                        },
                        startDate: DateTime.now()
                            .subtract(Duration(days: (DateTime.now().day) - 1)),
                      ),
                      GetBuilder(
                        init: controller,
                        id: "toDate",
                        builder: (_) {
                          controller.endDateTC.text =
                              controller.startDateTC.text;
                          return DateWithThreeTextField(
                            title: "End Date",
                            mainTextController: controller.endDateTC,
                            widthRation: .15,
                            startDate: controller.startDate,
                            endDate: controller.endDate,
                          );
                        },
                      ),
                      InputFields.formFieldDisable1(
                          hintTxt: "Created By",
                          value:
                              controller.loadModel?.tapeIdDetails.loginName ??
                                  "",
                          widthRatio: .15,
                          leftPad: 0),
                    ],
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return CupertinoSlidingSegmentedControl(
                          onValueChanged: (value) {
                            controller.selectedTab.value = value ?? 0;
                          },
                          children: <int, Widget>{
                            0: Text(
                              'Location & Channel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeDefine.fontSizeTab,
                              ),
                            ),
                            1: Text(
                              'History',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeDefine.fontSizeTab,
                              ),
                            ),
                          },
                          groupValue: controller.selectedTab.value,
                        );
                      }),
                      SizedBox(height: 10),
                      Expanded(
                        child: Obx(() {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Visibility(
                              visible: controller.selectedTab.value == 0,
                              replacement: (controller
                                              .history?.historyDetails ??
                                          [])
                                      .isEmpty
                                  ? const SizedBox()
                                  : GetBuilder<TapeIDCampaignController>(
                                      assignId: true,
                                      id: "grid",
                                      builder: (controller) {
                                        return DataGridFromMap3(
                                          checkBoxColumnKey: ["isActive"],
                                          actionIconKey: ["isActive"],
                                          checkBoxStrComparison: "true",
                                          uncheckCheckBoxStr: "false",
                                          colorCallback: (row) => (row.row.cells
                                                  .containsValue(controller
                                                      .historyManager
                                                      ?.currentCell))
                                              ? Colors.deepPurple.shade200
                                              : Colors.white,
                                          onload: (event) {
                                            controller.historyManager =
                                                event.stateManager;
                                            event.stateManager.setSelectingMode(
                                                PlutoGridSelectingMode.row);
                                            event.stateManager
                                                .setSelecting(true);
                                            event.stateManager.moveScrollByRow(
                                                PlutoMoveDirection.down,
                                                controller.historyEditIdx);
                                            event.stateManager.setCurrentCell(
                                              event.stateManager
                                                  .getRowByIdx(
                                                      controller.historyEditIdx)
                                                  ?.cells['isActive'],
                                              controller.historyEditIdx,
                                            );
                                          },
                                          onEdit: (event) {
                                            controller.historyEditIdx =
                                                event.rowIdx;
                                            controller
                                                .history
                                                ?.historyDetails[event.rowIdx]
                                                .isActive = (event
                                                    .value ==
                                                "true");
                                          },
                                          actionOnPress:
                                              (position, isSpaceCalled) {
                                            if (isSpaceCalled) {
                                              controller.historyEditIdx =
                                                  position.rowIdx ?? 0;
                                              controller.historyManager!
                                                  .changeCellValue(
                                                controller.historyManager!
                                                    .currentCell!,
                                                controller
                                                            .historyManager!
                                                            .currentCell!
                                                            .value ==
                                                        "true"
                                                    ? "false"
                                                    : "true",
                                                force: true,
                                                callOnChangedEvent: true,
                                                notify: true,
                                              );
                                            }
                                          },
                                          mapData: controller
                                                  .history?.historyDetails
                                                  .map((e) => e.toJson())
                                                  .toList() ??
                                              [],
                                          widthSpecificColumn:
                                              Get.find<HomeController>()
                                                  .getGridWidthByKey(
                                                      userGridSettingList:
                                                          controller
                                                              .userGridSetting1,
                                                      key: "tbl1"),
                                        );
                                      },
                                    ),
                              child: (controller.loadModel?.tapeIdDetails
                                              .locationLst ??
                                          [])
                                      .isEmpty
                                  ? const SizedBox()
                                  : GetBuilder<TapeIDCampaignController>(
                                      assignId: true,
                                      id: "grid",
                                      builder: (logic) {
                                        return DataGridFromMap3(
                                          colorCallback: (row) => (row.row.cells
                                                  .containsValue(controller
                                                      .locationChannelManager
                                                      ?.currentCell))
                                              ? Colors.deepPurple.shade200
                                              : Colors.white,
                                          onload: (event) {
                                            controller.locationChannelManager =
                                                event.stateManager;
                                            event.stateManager.setSelectingMode(
                                                PlutoGridSelectingMode.row);
                                            event.stateManager
                                                .setSelecting(true);
                                            event.stateManager.moveScrollByRow(
                                                PlutoMoveDirection.down,
                                                controller
                                                    .lastLocationChannelEditIdx);
                                            event.stateManager.setCurrentCell(
                                                event.stateManager
                                                    .getRowByIdx(controller
                                                        .lastLocationChannelEditIdx)
                                                    ?.cells['selectRow'],
                                                controller
                                                    .lastLocationChannelEditIdx);
                                          },
                                          checkBoxColumnKey: ["selectRow"],
                                          actionIconKey: ["selectRow"],
                                          checkBoxStrComparison: "true",
                                          uncheckCheckBoxStr: "false",
                                          onEdit: (event) {
                                            controller
                                                    .lastLocationChannelEditIdx =
                                                event.rowIdx;
                                            controller
                                                    .loadModel
                                                    ?.tapeIdDetails
                                                    .locationLst?[event.rowIdx]
                                                    .selectRow =
                                                (event.value == "true");
                                            controller
                                                    .loadModel
                                                    ?.tapeIdDetails
                                                    .locationLst?[event.rowIdx]
                                                    .startDate =
                                                DateFormat("dd-MMM-yyyy")
                                                    .format(
                                                        DateFormat("dd-MM-yyyy")
                                                            .parse(controller
                                                                .startDateTC
                                                                .text));
                                            controller
                                                    .loadModel
                                                    ?.tapeIdDetails
                                                    .locationLst?[event.rowIdx]
                                                    .endDate =
                                                DateFormat("dd-MMM-yyyy")
                                                    .format(
                                                        DateFormat("dd-MM-yyyy")
                                                            .parse(controller
                                                                .endDateTC
                                                                .text));
                                            controller.selectedTab.refresh();
                                          },
                                          actionOnPress:
                                              (position, isSpaceCalled) {
                                            if (isSpaceCalled) {
                                              controller
                                                      .lastLocationChannelEditIdx =
                                                  position.rowIdx ?? 0;
                                              controller.locationChannelManager!
                                                  .changeCellValue(
                                                controller
                                                    .locationChannelManager!
                                                    .currentCell!,
                                                controller.locationChannelManager!
                                                            .currentCell!.value ==
                                                        "true"
                                                    ? "false"
                                                    : "true",
                                                force: true,
                                                callOnChangedEvent: true,
                                                notify: true,
                                              );
                                            }
                                          },
                                          mapData: controller.loadModel
                                                  ?.tapeIdDetails.locationLst
                                                  ?.map((e) => e.toJson())
                                                  .toList() ??
                                              [],
                                          widthSpecificColumn:
                                              Get.find<HomeController>()
                                                  .getGridWidthByKey(
                                                      userGridSettingList:
                                                          controller
                                                              .userGridSetting1,
                                                      key: "tbl2"),
                                        );
                                      },
                                    ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
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
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in btncontroller.buttons!) ...{
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: ((Utils.btnAccessHandler(btn['name'],
                                            controller.formPermissions!) ==
                                        null))
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
