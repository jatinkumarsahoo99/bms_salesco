import 'dart:html';

import 'package:bms_salesco/widgets/gridFromMap1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                      Obx(() {
                        return InputFields.formFieldDisable1(
                          hintTxt: "Activity Month",
                          value: controller.activityMonth.value,
                          widthRatio: .15,
                          leftPad: 0,
                          txtColor: Colors.black,
                        );
                      }),
                      InputFields.formFieldDisable1(
                        hintTxt: "Client",
                        value: controller.loadModel?.tapeIdDetails.clientName ??
                            "",
                        widthRatio: .15,
                        txtColor: Colors.black,
                        leftPad: 0,
                      ),
                      InputFields.formFieldDisable1(
                        hintTxt: "Agency",
                        value: controller.loadModel?.tapeIdDetails.agencyName ??
                            "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
                      InputFields.formFieldDisable1(
                        hintTxt: "Brand",
                        value:
                            controller.loadModel?.tapeIdDetails.brandName ?? "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
                      InputFields.formFieldDisable1(
                        hintTxt: "Caption",
                        value: controller
                                .loadModel?.tapeIdDetails.commercialCaption ??
                            "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
                      InputFields.formFieldDisable1(
                        hintTxt: "Duration",
                        value: controller
                                .loadModel?.tapeIdDetails.commercialDuration
                                .toString() ??
                            "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
                      InputFields.formFieldDisable1(
                        hintTxt: "Agency Tape ID",
                        value:
                            controller.loadModel?.tapeIdDetails.agencytapeid ??
                                "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
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
                            controller.generateActivityMonth();
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
                            controller.loadModel?.tapeIdDetails.loginName ?? "",
                        widthRatio: .15,
                        leftPad: 0,
                        txtColor: Colors.black,
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FormButton(
                    btnText: "Import",
                    callback: () {
                      controller.handleImportTap();
                    },
                  ),
                ),
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
                            1: Text(
                              'Location & Channel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeDefine.fontSizeTab,
                              ),
                            ),
                            0: Text(
                              'History',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeDefine.fontSizeTab,
                              ),
                            ),
                            2: Text(
                              'Campaign History',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeDefine.fontSizeTab,
                              ),
                            ),
                            3: Text(
                              'Tape ID Campaign',
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
                          controller.selectedTab.value;
                          if (controller.selectedTab.value == 0) {
                            return DataGridFromMap3(
                              hideCode: false,
                              columnAutoResize: false,
                              exportFileName: "Tape ID Campaign",
                              checkBoxColumnKey: ["isActive"],
                              actionIconKey: ["isActive"],
                              checkBoxStrComparison: "true",
                              uncheckCheckBoxStr: "false",
                              mode: PlutoGridMode.selectWithOneTap,
                              colorCallback: (row) => (row.row.cells
                                      .containsValue(controller
                                          .historyManager?.currentCell))
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                              onload: (event) {
                                controller.historyManager = event.stateManager;
                                event.stateManager.setSelectingMode(
                                    PlutoGridSelectingMode.row);

                                event.stateManager.setCurrentCell(
                                  event.stateManager
                                      .getRowByIdx(controller.historyEditIdx)
                                      ?.cells['isActive'],
                                  controller.historyEditIdx,
                                );
                                event.stateManager.moveScrollByRow(
                                    PlutoMoveDirection.down,
                                    controller.historyEditIdx);
                              },
                              onEdit: (event) {
                                controller.historyEditIdx = event.rowIdx;
                                controller.history?.historyDetails[event.rowIdx]
                                    .isActive = (event.value == "true");
                              },
                              actionOnPress: (position, isSpaceCalled) {
                                if (isSpaceCalled) {
                                  controller.historyEditIdx =
                                      position.rowIdx ?? 0;
                                  controller.historyManager!.changeCellValue(
                                    controller.historyManager!.currentCell!,
                                    controller.historyManager!.currentCell!
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
                              mapData: controller.history?.historyDetails
                                      .map((e) => e.toJson())
                                      .toList() ??
                                  [],
                              widthSpecificColumn: Get.find<HomeController>()
                                  .getGridWidthByKey(
                                      userGridSettingList:
                                          controller.userGridSetting1,
                                      key: "tbl1"),
                            );
                          } else if (controller.selectedTab.value == 1) {
                            return DataGridFromMap3(
                              exportFileName: "Tape ID Campaign",
                              colorCallback: (row) => (row.row.cells
                                      .containsValue(controller
                                          .locationChannelManager?.currentCell))
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                              mode: PlutoGridMode.selectWithOneTap,
                              onload: (event) {
                                controller.locationChannelManager =
                                    event.stateManager;
                                // event.stateManager
                                //     .setSelectingMode(
                                //         PlutoGridSelectingMode
                                //             .row);
                                // event.stateManager
                                //     .setSelecting(true);

                                event.stateManager.setCurrentCell(
                                    event.stateManager
                                        .getRowByIdx(controller
                                            .lastLocationChannelEditIdx)
                                        ?.cells['locationName'],
                                    controller.lastLocationChannelEditIdx);
                                event.stateManager.moveScrollByRow(
                                    PlutoMoveDirection.down,
                                    controller.lastLocationChannelEditIdx);
                              },
                              checkBoxColumnKey: ["selectRow"],
                              actionIconKey: ["selectRow"],
                              checkBoxStrComparison: "true",
                              uncheckCheckBoxStr: "false",
                              onEdit: (event) {
                                controller.lastLocationChannelEditIdx =
                                    event.rowIdx;
                                controller
                                    .loadModel
                                    ?.tapeIdDetails
                                    .locationLst?[event.rowIdx]
                                    .selectRow = (event.value == "true");
                                controller
                                    .loadModel
                                    ?.tapeIdDetails
                                    .locationLst?[event.rowIdx]
                                    .startDate = (event.value ==
                                        "true")
                                    ? DateFormat("dd-MMM-yyyy").format(
                                        DateFormat("dd-MM-yyyy")
                                            .parse(controller.startDateTC.text))
                                    : '';
                                controller
                                    .loadModel
                                    ?.tapeIdDetails
                                    .locationLst?[event.rowIdx]
                                    .endDate = (event.value ==
                                        "true")
                                    ? DateFormat("dd-MMM-yyyy").format(
                                        DateFormat("dd-MM-yyyy")
                                            .parse(controller.endDateTC.text))
                                    : '';

                                controller.locationChannelManager
                                    ?.changeCellValue(
                                  event.row.cells['startDate']!,
                                  controller
                                          .loadModel
                                          ?.tapeIdDetails
                                          .locationLst?[event.rowIdx]
                                          .startDate ??
                                      '',
                                  callOnChangedEvent: false,
                                  force: true,
                                  notify: true,
                                );
                                controller.locationChannelManager
                                    ?.changeCellValue(
                                  event.row.cells['endDate']!,
                                  controller.loadModel?.tapeIdDetails
                                          .locationLst?[event.rowIdx].endDate ??
                                      '',
                                  callOnChangedEvent: false,
                                  force: true,
                                  notify: true,
                                );
                                // controller.selectedTab.refresh();
                              },
                              actionOnPress: (position, isSpaceCalled) {
                                if (isSpaceCalled) {
                                  controller.lastLocationChannelEditIdx =
                                      position.rowIdx ?? 0;
                                  controller.locationChannelManager!
                                      .changeCellValue(
                                    controller
                                        .locationChannelManager!.currentCell!,
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
                              mapData: controller
                                      .loadModel?.tapeIdDetails.locationLst
                                      ?.map((e) => e.toJson())
                                      .toList() ??
                                  [],
                              widthSpecificColumn: Get.find<HomeController>()
                                  .getGridWidthByKey(
                                      userGridSettingList:
                                          controller.userGridSetting1,
                                      key: "tbl2"),
                            );
                          } else if (controller.selectedTab.value == 2) {
                            return DataGridFromMap3(
                                mapData: controller.camoaignHistoryList.value
                                    .map((e) {
                                  if (e['startDate'] != null) {
                                    e['startDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['startDate']));
                                  }
                                  if (e['endDate'] != null) {
                                    e['endDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['endDate']));
                                  }
                                  if (e['createdDate'] != null) {
                                    e['createdDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['createdDate']));
                                  }
                                  return e;
                                }).toList(),
                                formatDate: false,
                                hideCode: false);
                          } else if (controller.selectedTab.value == 3) {
                            return DataGridFromMap3(
                                mapData: controller.tapeIdCampaignList.value
                                    .map((e) {
                                  if (e['startDate'] != null) {
                                    e['startDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['startDate']));
                                  }
                                  if (e['endDate'] != null) {
                                    e['endDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['endDate']));
                                  }
                                  if (e['createdDate'] != null) {
                                    e['createdDate'] = DateFormat('dd-MM-yyyy')
                                        .format(
                                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                                .parse(e['createdDate']));
                                  }
                                  return e;
                                }).toList(),
                                formatDate: false,
                                hideCode: false);
                          } else {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          // return Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Colors.grey,
                          //     ),
                          //   ),
                          //   child: controller.selectedTab.value > 1
                          //       ? SizedBox()
                          //       : Visibility(
                          //           visible: controller.selectedTab.value == 0,
                          //           replacement: (controller
                          //                           .history?.historyDetails ??
                          //                       [])
                          //                   .isEmpty
                          //               ? const SizedBox()
                          //               : DataGridFromMap3(
                          //                   hideCode: false,
                          //                   columnAutoResize: false,
                          //                   exportFileName: "Tape ID Campaign",
                          //                   checkBoxColumnKey: ["isActive"],
                          //                   actionIconKey: ["isActive"],
                          //                   checkBoxStrComparison: "true",
                          //                   uncheckCheckBoxStr: "false",
                          //                   mode:
                          //                       PlutoGridMode.selectWithOneTap,
                          //                   colorCallback: (row) => (row
                          //                           .row.cells
                          //                           .containsValue(controller
                          //                               .historyManager
                          //                               ?.currentCell))
                          //                       ? Colors.deepPurple.shade200
                          //                       : Colors.white,
                          //                   onload: (event) {
                          //                     controller.historyManager =
                          //                         event.stateManager;
                          //                     event.stateManager
                          //                         .setSelectingMode(
                          //                             PlutoGridSelectingMode
                          //                                 .row);

                          //                     event.stateManager.setCurrentCell(
                          //                       event.stateManager
                          //                           .getRowByIdx(controller
                          //                               .historyEditIdx)
                          //                           ?.cells['isActive'],
                          //                       controller.historyEditIdx,
                          //                     );
                          //                     event.stateManager
                          //                         .moveScrollByRow(
                          //                             PlutoMoveDirection.down,
                          //                             controller
                          //                                 .historyEditIdx);
                          //                   },
                          //                   onEdit: (event) {
                          //                     controller.historyEditIdx =
                          //                         event.rowIdx;
                          //                     controller
                          //                         .history
                          //                         ?.historyDetails[event.rowIdx]
                          //                         .isActive = (event
                          //                             .value ==
                          //                         "true");
                          //                   },
                          //                   actionOnPress:
                          //                       (position, isSpaceCalled) {
                          //                     if (isSpaceCalled) {
                          //                       controller.historyEditIdx =
                          //                           position.rowIdx ?? 0;
                          //                       controller.historyManager!
                          //                           .changeCellValue(
                          //                         controller.historyManager!
                          //                             .currentCell!,
                          //                         controller
                          //                                     .historyManager!
                          //                                     .currentCell!
                          //                                     .value ==
                          //                                 "true"
                          //                             ? "false"
                          //                             : "true",
                          //                         force: true,
                          //                         callOnChangedEvent: true,
                          //                         notify: true,
                          //                       );
                          //                     }
                          //                   },
                          //                   mapData: controller
                          //                           .history?.historyDetails
                          //                           .map((e) => e.toJson())
                          //                           .toList() ??
                          //                       [],
                          //                   widthSpecificColumn: Get.find<
                          //                           HomeController>()
                          //                       .getGridWidthByKey(
                          //                           userGridSettingList:
                          //                               controller
                          //                                   .userGridSetting1,
                          //                           key: "tbl1"),
                          //                 ),
                          //           child: (controller.loadModel?.tapeIdDetails
                          //                           .locationLst ??
                          //                       [])
                          //                   .isEmpty
                          //               ? const SizedBox()
                          //               : DataGridFromMap3(
                          //                   exportFileName: "Tape ID Campaign",
                          //                   colorCallback: (row) => (row
                          //                           .row.cells
                          //                           .containsValue(controller
                          //                               .locationChannelManager
                          //                               ?.currentCell))
                          //                       ? Colors.deepPurple.shade200
                          //                       : Colors.white,
                          //                   mode:
                          //                       PlutoGridMode.selectWithOneTap,
                          //                   onload: (event) {
                          //                     controller
                          //                             .locationChannelManager =
                          //                         event.stateManager;
                          //                     // event.stateManager
                          //                     //     .setSelectingMode(
                          //                     //         PlutoGridSelectingMode
                          //                     //             .row);
                          //                     // event.stateManager
                          //                     //     .setSelecting(true);

                          //                     event.stateManager.setCurrentCell(
                          //                         event.stateManager
                          //                             .getRowByIdx(controller
                          //                                 .lastLocationChannelEditIdx)
                          //                             ?.cells['locationName'],
                          //                         controller
                          //                             .lastLocationChannelEditIdx);
                          //                     event.stateManager.moveScrollByRow(
                          //                         PlutoMoveDirection.down,
                          //                         controller
                          //                             .lastLocationChannelEditIdx);
                          //                   },
                          //                   checkBoxColumnKey: ["selectRow"],
                          //                   actionIconKey: ["selectRow"],
                          //                   checkBoxStrComparison: "true",
                          //                   uncheckCheckBoxStr: "false",
                          //                   onEdit: (event) {
                          //                     controller
                          //                             .lastLocationChannelEditIdx =
                          //                         event.rowIdx;
                          //                     controller
                          //                         .loadModel
                          //                         ?.tapeIdDetails
                          //                         .locationLst?[event.rowIdx]
                          //                         .selectRow = (event
                          //                             .value ==
                          //                         "true");
                          //                     controller
                          //                         .loadModel
                          //                         ?.tapeIdDetails
                          //                         .locationLst?[event.rowIdx]
                          //                         .startDate = (event.value ==
                          //                             "true")
                          //                         ? DateFormat("dd-MMM-yyyy")
                          //                             .format(DateFormat(
                          //                                     "dd-MM-yyyy")
                          //                                 .parse(controller
                          //                                     .startDateTC
                          //                                     .text))
                          //                         : '';
                          //                     controller
                          //                         .loadModel
                          //                         ?.tapeIdDetails
                          //                         .locationLst?[event.rowIdx]
                          //                         .endDate = (event.value ==
                          //                             "true")
                          //                         ? DateFormat("dd-MMM-yyyy")
                          //                             .format(DateFormat(
                          //                                     "dd-MM-yyyy")
                          //                                 .parse(controller
                          //                                     .endDateTC.text))
                          //                         : '';

                          //                     controller.locationChannelManager
                          //                         ?.changeCellValue(
                          //                       event.row.cells['startDate']!,
                          //                       controller
                          //                               .loadModel
                          //                               ?.tapeIdDetails
                          //                               .locationLst?[
                          //                                   event.rowIdx]
                          //                               .startDate ??
                          //                           '',
                          //                       callOnChangedEvent: false,
                          //                       force: true,
                          //                       notify: true,
                          //                     );
                          //                     controller.locationChannelManager
                          //                         ?.changeCellValue(
                          //                       event.row.cells['endDate']!,
                          //                       controller
                          //                               .loadModel
                          //                               ?.tapeIdDetails
                          //                               .locationLst?[
                          //                                   event.rowIdx]
                          //                               .endDate ??
                          //                           '',
                          //                       callOnChangedEvent: false,
                          //                       force: true,
                          //                       notify: true,
                          //                     );
                          //                     // controller.selectedTab.refresh();
                          //                   },
                          //                   actionOnPress:
                          //                       (position, isSpaceCalled) {
                          //                     if (isSpaceCalled) {
                          //                       controller
                          //                               .lastLocationChannelEditIdx =
                          //                           position.rowIdx ?? 0;
                          //                       controller
                          //                           .locationChannelManager!
                          //                           .changeCellValue(
                          //                         controller
                          //                             .locationChannelManager!
                          //                             .currentCell!,
                          //                         controller
                          //                                     .locationChannelManager!
                          //                                     .currentCell!
                          //                                     .value ==
                          //                                 "true"
                          //                             ? "false"
                          //                             : "true",
                          //                         force: true,
                          //                         callOnChangedEvent: true,
                          //                         notify: true,
                          //                       );
                          //                     }
                          //                   },
                          //                   mapData: controller.loadModel
                          //                           ?.tapeIdDetails.locationLst
                          //                           ?.map((e) => e.toJson())
                          //                           .toList() ??
                          //                       [],
                          //                   widthSpecificColumn: Get.find<
                          //                           HomeController>()
                          //                       .getGridWidthByKey(
                          //                           userGridSettingList:
                          //                               controller
                          //                                   .userGridSetting1,
                          //                           key: "tbl2"),
                          //                 ),
                          //         ),
                          // );
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
