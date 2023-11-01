import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/widgets/CheckBoxWidget.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/SizeDefine.dart';
import '../../../routes/app_pages.dart';
import '../controllers/p_d_c_cheques_controller.dart';

class PDCChequesView extends StatelessWidget {
  const PDCChequesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.devicewidth,
        height: context.deviceheight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder(
            init: Get.put(PDCChequesController()),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 10,
                    children: [
                      DropDownField.formDropDownSearchAPI2(
                        GlobalKey(),
                        context,
                        title: "Client",
                        url: ApiFactory.PDC_CHEQUES_CLIENT,
                        onchanged: controller.handleOnChangeClient,
                        width: context.devicewidth * .12,
                        selectedValue: controller.selecctedClient,
                        customInData: 'clientModels',
                        parseKeyForKey: 'clientcode',
                        parseKeyForValue: 'clientname',
                      ),
                      DropDownField.formDropDown1Width(
                        context,
                        [],
                        (val) {},
                        "Agency",
                        .12,
                        paddingLeft: 0,
                      ),
                      InputFields.formField1(
                        width: .12,
                        hintTxt: "Bank",
                        controller: TextEditingController(text: ''),
                        padLeft: 0,
                      ),
                      DateWithThreeTextField(
                        title: "Recd on",
                        mainTextController: TextEditingController(),
                        widthRation: .12,
                      ),
                      InputFields.formField1(
                        width: .12,
                        hintTxt: "Recd By",
                        controller: TextEditingController(text: ''),
                        padLeft: 0,
                      ),
                      DateWithThreeTextField(
                        title: "CCD Verify Dt",
                        mainTextController: TextEditingController(),
                        widthRation: .12,
                      ),
                      InputFields.formField1(
                        width: .12,
                        hintTxt: "CCD Verify By",
                        controller: TextEditingController(text: ''),
                        padLeft: 0,
                      ),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.pdcTypeList.value,
                          (val) => controller.selectedPdcType = val,
                          "PDC Type",
                          .12,
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey[500]),
                          child: const SizedBox(
                            height: .5,
                            width: double.maxFinite,
                          ),
                        ),
                      ),
                      // DropDownField.formDropDownSearchAPI2(
                      //   GlobalKey(),
                      //   context,
                      //   title: "Client",
                      //   url: 'url',
                      //   onchanged: (p0) {},
                      //   width: context.devicewidth * .12,
                      // ),
                      DropDownField.formDropDown1Width(
                        context,
                        [],
                        (val) {},
                        "Agency",
                        .12,
                        paddingLeft: 0,
                      ),
                      InputFields.formField1(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Cheque No",
                        controller: TextEditingController(text: ''),
                      ),
                      DateWithThreeTextField(
                        title: "Cheque Dt",
                        mainTextController: TextEditingController(),
                        widthRation: .12,
                      ),
                      DateWithThreeTextField(
                        title: "Approved Till",
                        mainTextController: TextEditingController(),
                        widthRation: .12,
                      ),
                      CheckBoxWidget1(
                        title: 'Is Dummy',
                        value: true,
                      ),
                      InputFields.formField1(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Remarks",
                        controller: TextEditingController(text: ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey[500]),
                          child: const SizedBox(
                            height: .5,
                            width: double.maxFinite,
                          ),
                        ),
                      ),
                      InputFields.numbers(
                        width: .12,
                        padLeft: 0,
                        hintTxt: "Chq Amt",
                        controller: TextEditingController(text: '0'),
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      InputFields.numbers(
                        width: .12,
                        padLeft: 0,
                        hintTxt: "TDS Amt",
                        controller: TextEditingController(text: '0'),
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      InputFields.numbers(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Save Tax %",
                        controller: TextEditingController(text: '0'),
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      InputFields.formFieldDisable1(
                        leftPad: 0,
                        hintTxt: "Svc Tax Amt",
                        value: "",
                        widthRatio: .12,
                      ),
                      InputFields.formFieldDisable1(
                        leftPad: 0,
                        hintTxt: "Net Book Amt",
                        value: "",
                        widthRatio: .12,
                      ),
                      Row(),
                      InputFields.formField1(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Rev Chq No",
                        controller: TextEditingController(text: ''),
                      ),
                      InputFields.numbers(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Rev Chq Amt",
                        controller: TextEditingController(text: '0'),
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      InputFields.formField1(
                        padLeft: 0,
                        width: .12,
                        hintTxt: "Rev Bank",
                        controller: TextEditingController(text: ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                          'Cheque Grouping',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: SizeDefine.fontSizeTab,
                          ),
                        ),
                      },
                      groupValue: controller.selectedTab.value,
                    );
                  }),
                  Expanded(
                    child: Obx(() {
                      if (controller.selectedTab.value == 0) {
                        return Obx(() {
                          return DataGridFromMap3(
                            onSelected: (event) {
                              controller.locationChannelLastSelectedIdx =
                                  event.rowIdx!;
                            },
                            onload: (sm) {
                              sm.stateManager.setCurrentCell(
                                  sm.stateManager
                                      .getRowByIdx(controller
                                          .locationChannelLastSelectedIdx)
                                      ?.cells['selectRow'],
                                  controller.locationChannelLastSelectedIdx);
                              sm.stateManager.moveScrollByRow(
                                  PlutoMoveDirection.down,
                                  controller.locationChannelLastSelectedIdx);
                              controller.locationChannelSM = sm.stateManager;
                            },
                            mode: PlutoGridMode.selectWithOneTap,
                            mapData: controller.locationChannelList.value
                                .map((e) => e.toJson())
                                .toList(),
                            actionIconKey: ['selectRow'],
                            checkBoxColumnKey: ['selectRow'],
                            actionOnPress: (position, isSpaceCalled) {
                              if (isSpaceCalled) {
                                controller.locationChannelSM!.changeCellValue(
                                  controller.locationChannelSM!.currentCell!,
                                  (!(controller
                                              .locationChannelList[controller
                                                  .locationChannelSM!
                                                  .currentRow!
                                                  .sortIdx]
                                              .selectRow ??
                                          false))
                                      .toString(),
                                  callOnChangedEvent: true,
                                  force: true,
                                );
                              }
                            },
                            onEdit: (event) {
                              controller
                                  .locationChannelList
                                  .value[event.row.sortIdx]
                                  .selectRow = (event.value == "true");
                            },
                            checkBoxStrComparison: "true",
                            uncheckCheckBoxStr: "false",
                          );
                        });
                      } else if (controller.selectedTab.value == 1) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InputFields.numbers(
                                    padLeft: 0,
                                    width: .12,
                                    hintTxt: "Rev Chq Amt",
                                    controller:
                                        TextEditingController(text: '0'),
                                    isNegativeReq: false,
                                    inputformatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,4}'))
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  FormButton(
                                    btnText: "Save Cheque Grouping",
                                    callback: () {},
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                return DataGridFromMap3(
                                  mapData: controller.chequeGroupingList.value
                                      .map((e) {
                                    if (e['selectRow'] != null) {
                                      e['selectRow'] =
                                          e['selectRow'].toString();
                                    }
                                    return e;
                                  }).toList(),
                                  actionIconKey: ['selectRow'],
                                  checkBoxColumnKey: ['selectRow'],

                                  // actionOnPress: (position, isSpaceCalled) {},
                                  checkBoxStrComparison: "true",
                                  uncheckCheckBoxStr: "false",
                                );
                              }),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                  Get.find<HomeController>()
                      .getCommonButton<PDCChequesController>(
                    Routes.P_D_C_CHEQUES,
                    (formName) {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
