import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/HomeController.dart';
import '../controllers/view_old_deal_controller.dart';

class ViewOldDealView extends StatelessWidget {
  ViewOldDealView({Key? key}) : super(key: key);

  // ViewOldDealController controllerX = Get.find<ViewOldDealController>();

  ViewOldDealController controllerX =
      Get.put<ViewOldDealController>(ViewOldDealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ViewOldDealController>(
          id: "ref",
          builder: (controllerX) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(0.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 5,
                      spacing: Get.width * 0.01,
                      children: [
                        Obx(() => DropDownField.formDropDown1WidthMap(
                                controllerX.executiveList.value ?? [], (val) {
                              controllerX.selectedExecutiveList.value = val;
                            }, "Executive", .23,
                                autoFocus: true,
                                inkWellFocusNode: controllerX.executiveNode,
                                selected:
                                    controllerX.selectedExecutiveList.value)),
                        Obx(() => DropDownField.formDropDown1WidthMap(
                                controllerX.locationList.value ?? [], (valeu) {
                              controllerX.selectedLocationList.value = valeu;
                            }, "Location", .23,
                                autoFocus: true,
                                selected:
                                    controllerX.selectedLocationList.value,
                                inkWellFocusNode: controllerX.locationNode)),
                        Obx(() => DropDownField.formDropDown1WidthMap(
                              controllerX.channelList.value ?? [],
                              (valeu) {
                                controllerX.selectedChannelList.value = valeu;
                                controllerX.getClient();
                              },
                              "Channel",
                              inkWellFocusNode: controllerX.channelNode,
                              selected: controllerX.selectedChannelList.value,
                              .23,
                              autoFocus: true,
                            )),
                        DateWithThreeTextField(
                          title: "Date",
                          mainTextController: controllerX.dateController,
                          widthRation: .23,
                        ),
                        Obx(() => DropDownField.formDropDown1WidthMap(
                                controllerX.clientList.value ?? [], (valeu) {
                              controllerX.selectedClientList.value = valeu;
                              controllerX.getAgency();
                            }, "Client", .23,
                                autoFocus: true,
                                inkWellFocusNode: controllerX.clientNode,
                                selected:
                                    controllerX.selectedClientList.value)),
                        Obx(() => DropDownField.formDropDown1WidthMap(
                            controllerX.agencyList.value ?? [],
                            (valeu) {
                              controllerX.selectedAgencyList.value = valeu;
                              controllerX.getDeal();
                            },
                            "Agency",
                            .23,
                            autoFocus: true,
                            selected: controllerX.selectedAgencyList.value,
                            onFocusChange: (val) {
                              if (!val) {
                                controllerX.selectedDealNoList.value = null;
                                controllerX.selectedDealNoList.refresh();
                              }
                            },
                            inkWellFocusNode: controllerX.agencyNode)),
                        Obx(() => DropDownField.formDropDown1WidthMap(
                                controllerX.dealNoList.value ?? [], (valeu) {
                              controllerX.selectedDealNoList.value = valeu;
                              controllerX.dealLeaveNo();
                            }, "DealNo", .23,
                                autoFocus: true,
                                selected: controllerX.selectedDealNoList.value,
                                inkWellFocusNode: controllerX.dealNoNode)),
                        DateWithThreeTextField(
                          title: "DealPeriod From",
                          mainTextController:
                              controllerX.dealPeriodFromController,
                          widthRation: .11,
                        ),
                        DateWithThreeTextField(
                          title: "To Date",
                          mainTextController: controllerX.toDateFromController,
                          widthRation: .11,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GetBuilder<ViewOldDealController>(
                        assignId: true,
                        id: "grid",
                        builder: (controllerX) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: (controllerX.viewOldDealResponseModel?.deal
                                            ?.lstdealusage !=
                                        null &&
                                    (controllerX.viewOldDealResponseModel?.deal
                                                ?.lstdealusage?.length ??
                                            0) >
                                        0)
                                ? DataGridFromMap3(
                                    showSrNo: true,
                                    hideCode: false,
                                    formatDate: false,
                                    exportFileName: "View Old Deal",
                                    mode: PlutoGridMode.normal,
                                    mapData: (controllerX
                                        .viewOldDealResponseModel
                                        ?.deal
                                        ?.lstdealusage
                                        ?.map((e) => e.toJson())
                                        .toList())!,
                                    // mapData: (controllerX.dataList)!,
                                    widthRatio: Get.width / 9 - 1,
                                    widthSpecificColumn:
                                        Get.find<HomeController>()
                                            .getGridWidthByKey(
                                                userGridSettingList: controllerX
                                                    .userGridSetting1),
                                    onload: (PlutoGridOnLoadedEvent? event) {
                                      controllerX.stateManager =
                                          event?.stateManager;
                                    },
                                  )
                                : Container(),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          InputFields.formField1(
                              hintTxt: "Deal Amount",
                              width: .155,
                              controller: controllerX.dealAmountController),
                          SizedBox(
                            width: 10,
                          ),
                          InputFields.formField1(
                              hintTxt: "Total Deal Duration",
                              width: .155,
                              controller:
                                  controllerX.totalDealDurationController),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FormButtonWrapper(
                              btnText: "Clear",
                              callback: () {
                                print("clear");
                                Get.delete<ViewOldDealController>();
                                Get.find<HomeController>().clearPage1();
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          FormButtonWrapper(
                              btnText: "Exit",
                              callback: () {
                                Get.find<HomeController>().postUserGridSetting1(
                                    listStateManager: [
                                      controllerX.stateManager
                                    ]);
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
