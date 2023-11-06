import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/widgets/CheckBoxWidget.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/SizeDefine.dart';
import '../../../routes/app_pages.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../../CommonSearch/views/pivotPage.dart';
import '../../CommonSearch/views/searchResult.dart';
import '../controllers/p_d_c_cheques_controller.dart';

class PDCChequesView extends StatelessWidget {
  const PDCChequesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PDCChequesController());
    return Scaffold(
      floatingActionButton: Obx(() {
        return controller.dialogWidget.value != null
            ? DraggableFab(
                initPosition: controller.initPosition,
                child: controller.dialogWidget.value!,
              )
            : const SizedBox();
      }),
      body: SizedBox(
        width: context.devicewidth,
        height: context.deviceheight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // width: context.devicewidth * .55,
                        child: Wrap(
                          runSpacing: 5,
                          spacing: 10,
                          children: [
                            GetBuilder(
                                init: controller,
                                id: "client",
                                builder: (_) {
                                  return DropDownField.formDropDownSearchAPI2(
                                    GlobalKey(),
                                    context,
                                    title: "Client",
                                    url: ApiFactory.PDC_CHEQUES_CLIENT,
                                    onchanged: controller.handleOnChangeClient,
                                    width: context.devicewidth *
                                        controller.widthRation,
                                    selectedValue: controller.selecctedClient,
                                    customInData: 'clientModels',
                                    parseKeyForKey: 'clientcode',
                                    parseKeyForValue: 'clientname',
                                    widthofDialog: 250,
                                    inkwellFocus: controller.clientFN,
                                    autoFocus: true,
                                  );
                                }),
                            InputFields.formField1(
                              width: controller.widthRation,
                              hintTxt: "Bank",
                              controller: controller.bankTC,
                              padLeft: 0,
                            ),
                            DateWithThreeTextField(
                              title: "Recd on",
                              mainTextController: controller.recdOnDateTC,
                              widthRation: controller.widthRation,
                            ),
                            InputFields.formField1(
                              width: controller.widthRation,
                              hintTxt: "Recd By",
                              controller: controller.recdByTC,
                              padLeft: 0,
                            ),
                            DateWithThreeTextField(
                              title: "CCD Verify Dt",
                              mainTextController: controller.ccdVerifyDateTC,
                              widthRation: controller.widthRation,
                            ),
                            InputFields.formField1(
                              width: controller.widthRation,
                              hintTxt: "CCD Verify By",
                              controller: controller.ccdVerifyByTC,
                              padLeft: 0,
                            ),
                            Obx(() {
                              return DropDownField.formDropDown1WidthMap(
                                controller.pdcTypeList.value,
                                (val) => controller.selectedPdcType = val,
                                "PDC Type",
                                controller.widthRation,
                                selected: controller.selectedPdcType,
                              );
                            }),
                          ],
                        ),
                      ),
                      Expanded(
                        // width: context.devicewidth * .55,
                        child: Wrap(
                          runSpacing: 5,
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Obx(() {
                              return DropDownField.formDropDown1WidthMap(
                                controller.agencyList.value,
                                (val) => controller.selectedAgency = val,
                                "Agency",
                                controller.widthRation,
                                dialogWidth: 250,
                                selected: controller.selectedAgency,
                              );
                            }),
                            InputFields.formField1(
                              padLeft: 0,
                              width: controller.widthRation,
                              hintTxt: "Cheque No",
                              controller: controller.chequeNoTC,
                            ),
                            DateWithThreeTextField(
                              title: "Cheque Dt",
                              mainTextController: controller.chequeDateTC,
                              widthRation: controller.widthRation,
                            ),
                            DateWithThreeTextField(
                              title: "Approved Till",
                              mainTextController: controller.approvedTillDateTC,
                              widthRation: controller.widthRation,
                            ),
                            InputFields.formField1(
                              padLeft: 0,
                              width: controller.widthRation,
                              hintTxt: "Remarks",
                              controller: controller.remarksTC,
                            ),
                            Obx(() {
                              return CheckBoxWidget1(
                                title: 'Is Dummy',
                                value: controller.isDummy.value,
                                onChanged: (newVal) {
                                  controller.isDummy.value = newVal ?? false;
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    // crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 10,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 4),
                      //   child: DecoratedBox(
                      //     decoration: BoxDecoration(color: Colors.grey[500]),
                      //     child: const SizedBox(
                      //       height: .5,
                      //       width: double.maxFinite,
                      //     ),
                      //   ),
                      // ),

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
                        width: controller.widthRation,
                        padLeft: 0,
                        hintTxt: "Chq Amt",
                        controller: controller.checkAmtTC,
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            controller.calculateTotal();
                          }
                        },
                      ),
                      InputFields.numbers(
                        width: controller.widthRation,
                        padLeft: 0,
                        hintTxt: "TDS Amt",
                        controller: controller.tdsAmtTC,
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            controller.calculateTotal();
                          }
                        },
                      ),
                      InputFields.numbers(
                        padLeft: 0,
                        width: controller.widthRation,
                        hintTxt: "Svc Tax %",
                        controller: controller.saveTaxTC,
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            controller.calculateTotal();
                          }
                        },
                      ),
                      Obx(() {
                        return InputFields.formFieldDisable1(
                          leftPad: 0,
                          hintTxt: "Svc Tax Amt",
                          value: controller.saveTaxAmt.value,
                          widthRatio: controller.widthRation,
                          txtColor: Colors.black,
                        );
                      }),
                      Obx(() {
                        return InputFields.formFieldDisable1(
                          leftPad: 0,
                          hintTxt: "Net Book Amt",
                          value: controller.newBookAmt.value,
                          widthRatio: controller.widthRation,
                          txtColor: Colors.black,
                        );
                      }),
                      Row(),
                      InputFields.formField1(
                        padLeft: 0,
                        width: controller.widthRation + .157,
                        hintTxt: "Rev Chq No",
                        controller: controller.revChqNoTC,
                      ),
                      InputFields.numbers(
                        padLeft: 0,
                        width: controller.widthRation,
                        hintTxt: "Rev Chq Amt",
                        controller: controller.revChqAmtTC,
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      InputFields.formField1(
                        padLeft: 0,
                        width: controller.widthRation + .157,
                        hintTxt: "Rev Bank",
                        controller: controller.revBankTC,
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
                            exportFileName: 'PDC Cheque',
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
                            colorCallback: (cell) =>
                                controller.locationChannelSM?.currentRow ==
                                        cell.row
                                    ? Colors.deepPurple.shade100
                                    : Colors.white,
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
                                    hintTxt: "Activity Month",
                                    controller: controller.activityMonthTC,
                                    isNegativeReq: false,
                                    inputformatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,4}'))
                                    ],
                                    focusNode: controller.activityMonthFN,
                                  ),
                                  SizedBox(width: 15),
                                  FormButton(
                                    btnText: "Save Cheque Grouping",
                                    callback: controller.saveChequeBookingData,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                return DataGridFromMap3(
                                  exportFileName: 'PDC Cheque',
                                  onload: (sm) {
                                    sm.stateManager.setCurrentCell(
                                        sm.stateManager
                                            .getRowByIdx(controller
                                                .chequeGroupingLastSelectedIdx)
                                            ?.cells['selectRow'],
                                        controller
                                            .chequeGroupingLastSelectedIdx);
                                    sm.stateManager.moveScrollByRow(
                                        PlutoMoveDirection.down,
                                        controller
                                            .chequeGroupingLastSelectedIdx);
                                    controller.chequeGroupingSM =
                                        sm.stateManager;
                                  },
                                  mode: PlutoGridMode.selectWithOneTap,
                                  onSelected: (event) {
                                    controller.chequeGroupingLastSelectedIdx =
                                        event.rowIdx!;
                                  },
                                  onEdit: (event) {
                                    controller
                                        .chequeGroupingList
                                        .value[event.row.sortIdx]
                                        .selectRow = (event.value == "true");
                                  },
                                  actionOnPress: (position, isSpaceCalled) {
                                    if (isSpaceCalled) {
                                      controller.chequeGroupingSM!
                                          .changeCellValue(
                                        controller
                                            .chequeGroupingSM!.currentCell!,
                                        (!(controller
                                                    .chequeGroupingList[
                                                        controller
                                                            .chequeGroupingSM!
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
                                  mapData: controller.chequeGroupingList
                                      .map((element) => element.toJson())
                                      .toList(),
                                  actionIconKey: ['selectRow'],
                                  checkBoxColumnKey: ['selectRow'],
                                  colorCallback: (cell) =>
                                      controller.chequeGroupingSM?.currentRow ==
                                              cell.row
                                          ? Colors.deepPurple.shade100
                                          : Colors.white,
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
                    (btnName) {
                      if (btnName == "Save") {
                        if (controller.chequeID == 0) {
                          controller.saveData();
                        } else {
                          LoadingDialog.recordExists(
                              "Do you want to modify this PDC info?", () {
                            controller.saveData();
                          });
                        }
                      } else if (btnName == "Docs") {
                        controller.docs();
                      } else if (btnName == "Search") {
                        Get.focusScope?.unfocus();
                        controller.dialogWidget.value = SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .8,
                          child: SearchPage(
                            key: Key("PDC Cheque"),
                            screenName: "PDC Cheque",
                            appBarName: "PDC Cheque",
                            strViewName: "bms_search_ClientPDc",
                            isAppBarReq: true,
                            dialogClose: (val) {
                              if (val is SearchPivotPage ||
                                  val is SearchResultPage) {
                                controller.dialogWidget.value = SizedBox(
                                  width: MediaQuery.of(context).size.width * .9,
                                  height:
                                      MediaQuery.of(context).size.height * .8,
                                  child: val,
                                );
                              } else if (val is PlutoRow) {
                                controller.getRetriveData(
                                    chequeId: int.tryParse(
                                            val.cells['ChequeId']!.value) ??
                                        0);

                                controller.initPosition = Offset(
                                  context.devicewidth * .8,
                                  context.deviceheight * .8,
                                );
                                controller.dialogWidget.refresh();
                                // controller.dialogWidget.value = null;
                              } else {
                                controller.dialogWidget.value = null;
                              }
                              controller.dialogWidget.refresh();
                            },
                          ),
                        );
                      }
                    },
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
