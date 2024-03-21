import 'dart:async';
import 'dart:html';
import 'dart:html' as html;
import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/data/PermissionModel.dart';
import 'package:bms_salesco/app/providers/DataGridMenu.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/app/providers/extensions/datagrid.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:bms_salesco/widgets/LoadingScreen.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:pluto_grid/pluto_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../data/rowfilter.dart';
import '../../../providers/Utils.dart';
import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
import '../controllers/edi_ro_booking_controller.dart';

class EdiRoBookingView extends StatelessWidget {
  EdiRoBookingView({Key? key}) : super(key: key);
  var maincontroller =
      Get.put<EdiRoBookingController>(EdiRoBookingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EdiRoBookingController>(
        init: maincontroller,
        id: "initData",
        builder: (controller) {
          print("init builder reload -${controller.initData == null}");
          // if (controller.initData == null) {
          //   return PleaseWaitCard();
          // }
          return RawKeyboardListener(
            focusNode: new FocusNode(),
            onKey: (RawKeyEvent raw) {
              controller.keyBoardHander(raw, context);
            },
            child: Scaffold(
              floatingActionButton:
                  Obx(() => controller.drgabbleDialog.value != null
                      ? DraggableFab(
                          key: maincontroller.valueKey,
                          // initPosition: Offset(
                          //     context.devicewidth / 3, context.deviceheight / 3),
                          child: controller.drgabbleDialog.value!,
                        )
                      : const SizedBox()),
              backgroundColor: Colors.grey[50],
              body: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (value) {
                  if (value.isKeyPressed(LogicalKeyboardKey.escape)) {
                    controller.drgabbleDialog.value = null;
                  }
                },
                child: FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: Get.width * 0.45,
                              child: Wrap(
                                spacing: Get.width * 0.005,
                                runSpacing: 5,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(1),
                                    child: DropDownField.formDropDown1WidthMap(
                                      controller.fileNames.value,
                                      (data) {
                                        controller.selectedFile = data;
                                        controller.effectiveDateLeave();
                                      },
                                      "Filename  ",
                                      .404,
                                      selected: controller.selectedFile,
                                      isEnable: controller.isEnable.value,
                                      autoFocus: true,
                                      titleInLeft: true,
                                      inkWellFocusNode: controller.fileNameFN,
                                    ),
                                  ),
                                  DropDownField.formDropDown1WidthMap(
                                      controller.strRoRefNo.value, (data) {
                                    controller.selectedRoRefNo = data;
                                  }, "RO Ref No", .32,
                                      selected: controller.selectedRoRefNo,
                                      isEnable: controller.isEnable.value,
                                      titleInLeft: true),
                                  Obx(
                                    () => FocusTraversalOrder(
                                      order: const NumericFocusOrder(4),
                                      child: SizedBox(
                                        width: Get.width * 0.08,
                                        child: FormButtonWrapper(
                                          btnText: "Show & Link",
                                          callback: () {
                                            controller.effDateFN.requestFocus();
                                            controller.showLink();
                                          },
                                          showIcon: false,
                                          isEnabled:
                                              controller.isShowLink.value,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DropDownField.formDropDown1WidthMap(
                                      controller.loactions.value, (data) {
                                    controller.selectedLoactions = data;
                                    controller.locationLeave(data.key);
                                  }, "Location   ", .17,
                                      selected: controller.selectedLoactions,
                                      isEnable: controller.isEnable.value,
                                      titleInLeft: true),
                                  DropDownField.formDropDown1WidthMap(
                                      controller.channel.value, (data) {
                                    controller.selectedChannel = data;
                                  }, "Channel   ", .17,
                                      isEnable: controller.isEnable.value,
                                      selected: controller.selectedChannel,
                                      titleInLeft: true),
                                  DropDownField.formDropDown1WidthMap(
                                    controller.client.value,
                                    (data) {
                                      controller.selectedClient = data;
                                    },
                                    "Client        ",
                                    .17,
                                    selected: controller.selectedClient,
                                    isEnable: controller.isEnable.value,
                                    titleInLeft: true,
                                  ),
                                  DropDownField.formDropDown1WidthMap(
                                    controller.agency.value,
                                    (data) {
                                      // controller.agencyLeave();
                                    },
                                    "Agency  ",
                                    .17,
                                    titleInLeft: true,
                                    selected: controller.selectedAgency,
                                    isEnable: controller.isEnable.value,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FocusTraversalOrder(
                                        order: const NumericFocusOrder(2),
                                        child:
                                            DropDownField.formDropDown1WidthMap(
                                                controller.dealNo.value,
                                                (data) {
                                          controller.selectedDealNo = data;

                                          controller.dealLeave();
                                        }, "Deal No.   ", .100,
                                                dialogHeight: 250,
                                                selected:
                                                    controller.selectedDealNo,
                                                titleInLeft: true),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InputFields.formField1(
                                          hintTxt: "",
                                          controller: controller.dealTypeTEC,
                                          width: 0.100,
                                          isEnable: false,
                                          showTitle: false),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Obx(
                                        () => FocusTraversalOrder(
                                          order: const NumericFocusOrder(3),
                                          child: DropDownField
                                              .formDropDown1WidthMap(
                                            controller.brand.value,
                                            (data) {
                                              controller.selectedBrand = data;
                                              controller.brandLeave(data.key);
                                            },
                                            "Brand",
                                            .17,
                                            titleInLeft: true,
                                            autoFocus: true,
                                            selected: controller.selectedBrand,
                                            isEnable:
                                                controller.isBrandEnable.value,
                                            inkWellFocusNode:
                                                controller.brandFN,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      DateWithThreeTextField(
                                        title: "Start Date",
                                        mainTextController:
                                            controller.startDateTEC,
                                        widthRation: .110,
                                        isEnable: false,
                                        titleInLeft: true,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      DateWithThreeTextField(
                                        title: "End Date",
                                        mainTextController:
                                            controller.endDateTEC,
                                        widthRation: .110,
                                        isEnable: false,
                                        titleInLeft: true,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InputFields.formField3(
                                        hintTxt: "Zone ",
                                        isEnable: false,
                                        controller: controller.zoneTEC,
                                        width: 0.105,
                                        titleInLeft: true,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: SizedBox(
                              width: Get.width * 0.18,
                              child: Wrap(
                                spacing: Get.width * 0.005,
                                runSpacing: 5,
                                children: [
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(5),
                                    child: DateWithThreeTextField(
                                      title: "Eff Date   ",
                                      mainTextController:
                                          controller.effectiveDate,
                                      widthRation: .08,
                                      titleInLeft: true,
                                      onFocusChange: (date) {},
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      FocusTraversalOrder(
                                        order: const NumericFocusOrder(6),
                                        child: DateWithThreeTextField(
                                          title: "Bk. Date  ",
                                          mainTextController: controller.bkDate,
                                          widthRation: .08,
                                          titleInLeft: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.payRouteCodeTEC,
                                        width: 0.055,
                                        showTitle: false,
                                        titleInLeft: true,
                                      ),
                                    ],
                                  ),
                                  InputFields.formField3(
                                    hintTxt: "Pay Route ",
                                    isEnable: false,
                                    controller: controller.payRouteTEC,
                                    width: 0.137,
                                    titleInLeft: true,
                                  ),
                                  InputFields.formField3(
                                    hintTxt: "Pay Mode ",
                                    isEnable: false,
                                    controller: controller.payModeTEC,
                                    width: 0.137,
                                    titleInLeft: true,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.18,
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        FocusTraversalOrder(
                                          order: const NumericFocusOrder(7),
                                          child: InputFields.formField1(
                                            hintTxt: "Booking No",
                                            controller:
                                                controller.bookingNo1TEC,
                                            width: 0.045,
                                            titleInLeft: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        FocusTraversalOrder(
                                          order: const NumericFocusOrder(8),
                                          child: InputFields.formField1(
                                            hintTxt: "",
                                            controller:
                                                controller.bookingNo2TEC,
                                            width: 0.045,
                                            titleInLeft: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        FocusTraversalOrder(
                                          order: const NumericFocusOrder(9),
                                          child: InputFields.formField1(
                                            hintTxt: "",
                                            controller:
                                                controller.bookingNo3TEC,
                                            width: 0.039,
                                            titleInLeft: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => FocusTraversalOrder(
                                      order: const NumericFocusOrder(13),
                                      child:
                                          DropDownField.formDropDown1WidthMap(
                                        controller.executives.value,
                                        (data) {
                                          controller.selectedExecutives = data;
                                        },
                                        "Executive",
                                        .136,
                                        selected: controller.selectedExecutives,
                                        autoFocus: true,
                                        dialogHeight: 250,
                                        titleInLeft: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(4),
                              child: SizedBox(
                                  width: Get.width * 0.24,
                                  child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      spacing: Get.width * 0.005,
                                      runSpacing: 5,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Get.width * 0.05,
                                          child: Text(
                                            "All",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.labelSize1),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 13,
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Get.width * 0.05,
                                          child: Text(
                                            "Booked",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.labelSize1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Get.width * 0.05,
                                          child: Text(
                                            "Balance",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.labelSize1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Get.width * 0.05,
                                          child: Text(
                                            "Val Amount",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.labelSize1),
                                          ),
                                        ),
                                        InputFields.formField3(
                                          hintTxt: "Spots",
                                          isEnable: false,
                                          controller: controller.spotsAllTEC,
                                          width: 0.05,
                                          titleInLeft: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller: controller.spotsBookedTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller:
                                              controller.spotsBalanceTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   width: Get.width * 0.05,
                                        // ),
                                        InputFields.formField3(
                                          hintTxt: "Dur    ",
                                          isEnable: false,
                                          controller: controller.durAllTEC,
                                          width: 0.05,
                                          titleInLeft: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller: controller.durBookedTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller: controller.durBalanceTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   width: Get.width * 0.05,
                                        // ),
                                        InputFields.formField3(
                                          hintTxt: "Amt   ",
                                          isEnable: false,
                                          controller: controller.amtAllTEC,
                                          width: 0.05,
                                          titleInLeft: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller: controller.amtBookedTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller: controller.amtBalanceTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          isEnable: false,
                                          controller:
                                              controller.amtValAmmountTEC,
                                          width: 0.05,
                                          showTitle: false,
                                        ),
                                        Obx(
                                          () => FocusTraversalOrder(
                                            order: const NumericFocusOrder(10),
                                            child: DropDownField
                                                .formDropDown1WidthMap(
                                              controller.positions.value,
                                              (data) {
                                                controller.selectedPositions =
                                                    data;
                                              },
                                              "Position",
                                              .125,
                                              selected:
                                                  controller.selectedPositions,
                                              autoFocus: true,
                                            ),
                                          ),
                                        ),
                                        InputFields.formField3(
                                          hintTxt: "Pre. V Amt",
                                          isEnable: false,
                                          controller: controller.preVAmtTEC,
                                          width: 0.05,
                                        ),
                                        InputFields.formField3(
                                          hintTxt: "Pre. B Amt",
                                          isEnable: false,
                                          controller: controller.preBAmtTEC,
                                          width: 0.05,
                                        ),
                                        FocusTraversalOrder(
                                          order: const NumericFocusOrder(11),
                                          child: Container(
                                            width: Get.width * 0.115,
                                            child: FormButtonWrapper(
                                              showIcon: true,
                                              iconDataM: Icons
                                                  .video_collection_rounded,
                                              btnText: "Show Programs",
                                              callback: () {
                                                controller
                                                    .showProgramDilogBox();
                                              },
                                            ),
                                          ),
                                        ),
                                        FocusTraversalOrder(
                                          order: const NumericFocusOrder(12),
                                          child: Container(
                                            width: Get.width * 0.115,
                                            child: FormButtonWrapper(
                                              showIcon: true,
                                              iconDataM:
                                                  Icons.done_outline_rounded,
                                              btnText: "Mark Done",
                                              callback: () {
                                                controller.onMarkAsDone();
                                              },
                                            ),
                                          ),
                                        ),
                                      ]))),
                          Column(
                            children: [
                              GetBuilder(
                                  init: controller,
                                  id: "totalAmount",
                                  builder: (controller) {
                                    return Padding(
                                        padding: EdgeInsets.all(4),
                                        child: SizedBox(
                                            width: Get.width * 0.07,
                                            child: Wrap(
                                              children: [
                                                InputFields.formField3(
                                                  hintTxt: "Max Spend",
                                                  isEnable: false,
                                                  controller:
                                                      controller.maxSpendTEC,
                                                  width: 0.05,
                                                ),
                                                InputFields.formField3(
                                                  hintTxt: "Booked Amount",
                                                  isEnable: false,
                                                  controller: controller
                                                      .bookedAmountTEC,
                                                  width: 0.05,
                                                ),
                                                InputFields.formField3(
                                                  hintTxt: "Val Amount",
                                                  isEnable: false,
                                                  controller:
                                                      controller.valAmountTEC,
                                                  width: 0.05,
                                                ),
                                              ],
                                            )));
                                  }),
                              const SizedBox(
                                height: 8,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.lDButton.value,
                                  child: FormButtonWrapper(
                                    btnText: controller.linkDealName.value,
                                    callback: () {
                                      controller.showDilogBox();
                                    },
                                    showIcon: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(
                        () => controller.lstDgvDealEntriesList.value.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                child: Container(
                                  height: Get.height * 0.30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                ),
                              )
                            : SizedBox(
                                height: Get.height * 0.30,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: DataGridFromMap3(
                                    mode: PlutoGridMode.normal,
                                    mapData: controller
                                        .lstDgvDealEntriesList.value
                                        .map((e) {
                                      if (e['fromdate'] != null) {
                                        e['fromdate'] = controller
                                            .convertDate(e['fromdate']);
                                      }
                                      if (e['todate'] != null) {
                                        e['todate'] =
                                            controller.convertDate(e['todate']);
                                      }
                                      if (e['startdate'] != null) {
                                        e['startdate'] = controller
                                            .convertDate(e['startdate']);
                                      }
                                      if (e['enddate'] != null) {
                                        e['enddate'] = controller
                                            .convertDate(e['enddate']);
                                      }
                                      return e;
                                    }).toList(),
                                    hideCode: false,
                                    exportFileName: "EDI R.O. Booking",
                                    onload: (load) {
                                      controller.dgvDealEntriesGrid =
                                          load.stateManager;
                                      load.stateManager.setSelectingMode(
                                          PlutoGridSelectingMode.row);
                                      load.stateManager.setCurrentCell(
                                          load.stateManager.firstCell, 0);
                                    },
                                    colorCallback: (row) => row.row.cells
                                            .containsValue(controller
                                                .dgvDealEntriesGrid
                                                ?.currentCell)
                                        ? Colors.deepPurple.shade100
                                        : Colors.white,
                                    onRowDoubleTap: (event) {
                                      controller.dgvDealEntriesGrid
                                          ?.setCurrentCell(
                                              event.cell, event.rowIdx);

                                      controller.dealSpotsValidation(
                                          event.cell.row.sortIdx,
                                          showMessage: true);
                                    },
                                    columnAutoResize: false,
                                    widthSpecificColumn:
                                        Get.find<HomeController>()
                                            .getGridWidthByKey(
                                                userGridSettingList:
                                                    controller.userGridSetting1,
                                                key: "tbl1"),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Obx(() => Expanded(
                            child: controller.lstDgvSpotsList.value.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: Container(
                                      child: DataGridFromMap3(
                                        mode: PlutoGridMode.normal,
                                        // onSelected: (event) {
                                        //   controller.isSelectingChange.value =
                                        //       false;
                                        // },
                                        editKeys: const ['noProgram'],
                                        hideKeys: const [
                                          'backColor',
                                          'selected',
                                          'isSpotsAvailable'
                                        ],
                                        mapData: controller
                                            .lstDgvSpotsList.value
                                            .map((e) {
                                          if (e['fctok'] != null) {
                                            e['fctok'] = num.parse(e['fctok']);
                                          }
                                          if (e['dealOK'] != null) {
                                            e['dealOK'] =
                                                num.parse(e['dealOK']);
                                          }
                                          if (e['nO_SPOT'] != null) {
                                            e['nO_SPOT'] =
                                                num.parse(e['nO_SPOT']);
                                          }
                                          if (e['okSpot'] != null) {
                                            e['okSpot'] =
                                                num.parse(e['okSpot']);
                                          }
                                          if (e['groupcode'] != null) {
                                            e['groupcode'] =
                                                num.parse(e['groupcode']);
                                          }
                                          return e;
                                        }).toList(),
                                        hideCode: false,
                                        formatDate: false,
                                        exportFileName: "EDI R.O. Booking",
                                        onload: (load) {
                                          load.stateManager.setCurrentCell(
                                              load.stateManager
                                                  .getRowByIdx(controller
                                                      .lastSelectedIdx)!
                                                  .cells['program'],
                                              controller.lastSelectedIdx);
                                          load.stateManager
                                              .moveCurrentCellByRowIdx(
                                                  controller.lastSelectedIdx,
                                                  PlutoMoveDirection.down);
                                          load.stateManager.scroll.vertical!
                                              .animateTo(
                                                  controller.lastSelectedOffect,
                                                  curve: Curves.ease,
                                                  duration: Duration(
                                                      milliseconds: 2));
                                          load.stateManager.setSelectingMode(
                                              PlutoGridSelectingMode.row);
                                          load.stateManager.setCurrentCell(
                                              load.stateManager.firstCell, 0);
                                          load.stateManager
                                              .onSelectCellCallback = () {
                                            if (controller
                                                .isSelectingChange.value) {
                                              controller.isSelectingChange
                                                  .value = false;
                                            }
                                          };
                                          controller.dvgSpotGrid =
                                              load.stateManager;
                                        },
                                        colorCallback: (colorEvent) {
                                          controller.coloerEvents = colorEvent;
                                          if (colorEvent.row.cells
                                              .containsValue(controller
                                                  .dvgSpotGrid?.currentCell)) {
                                            return Colors.deepPurple.shade100;
                                          }
                                          if (controller.lstDgvSpotsList[
                                                          colorEvent.rowIdx]
                                                      ['isSpotsAvailable'] !=
                                                  null &&
                                              controller.lstDgvSpotsList[
                                                      colorEvent.rowIdx]
                                                  ['isSpotsAvailable'] &&
                                              controller
                                                  .isSelectingChange.value) {
                                            return Colors.deepPurple.shade100;
                                          }

                                          return controller.getColor(
                                            controller.lstDgvSpotsList[
                                                colorEvent.rowIdx],
                                            colorEvent.row,
                                          );
                                        },
                                        onRowDoubleTap: (event) async {
                                          controller.lastSelectedOffect =
                                              controller.dvgSpotGrid!.scroll
                                                  .verticalOffset;
                                          controller.lastSelectedIdx =
                                              event.rowIdx;
                                          //Down Grid Set
                                          controller.dvgSpotGrid
                                              ?.setCurrentCell(
                                                  event.cell, event.rowIdx);
                                          //Clear
                                          if (Get.find<MainController>()
                                              .filters1
                                              .containsKey(controller
                                                  .dgvDealEntriesGrid.hashCode
                                                  .toString())) {
                                            print(controller
                                                .dgvDealEntriesGrid.hashCode
                                                .toString());
                                            await controller
                                                .clearFirstDataTableFilter(
                                                    controller
                                                        .dgvDealEntriesGrid!);
                                          }
                                          //Up Grid Set
                                          for (var element in controller
                                              .dgvDealEntriesGrid!.rows) {
                                            if (element.cells['costPer10Sec']
                                                    ?.value ==
                                                event.cell.value) {
                                              controller.dgvDealEntriesGrid
                                                  ?.setCurrentCell(
                                                      element.cells[
                                                          'costPer10Sec'],
                                                      element.sortIdx);
                                              break;
                                            }
                                          }

                                          // print(event.cell.row.sortIdx);
                                          // print(event.cell.value);
                                          // print(event.cell.column.field);
                                          // print(event.row.cells['acT_DT']?.value);

                                          if (event.cell.column.field
                                                  .toString() ==
                                              'fpcstart') {
                                            controller.spotFpcStart(
                                                controller
                                                    .selectedLoactions?.key,
                                                controller.selectedChannel?.key,
                                                event.row.cells['acT_DT']?.value
                                                    .toString());
                                          } else if (event.cell.column.field
                                                  .toString() ==
                                              'program') {
                                            event.row.cells['noProgram']
                                                ?.value = 1;
                                            event.row.cells['dealOK']?.value =
                                                0;
                                            event.row.cells['fctok']?.value = 0;
                                            event.row.cells['okSpot']?.value =
                                                0;

                                            controller.lstDgvSpotsList[event
                                                .row.sortIdx]['noProgram'] = 1;
                                            controller.lstDgvSpotsList[event
                                                .row.sortIdx]['dealOK'] = 0;
                                            controller.lstDgvSpotsList[
                                                event.row.sortIdx]['fctok'] = 0;
                                            controller.lstDgvSpotsList[event
                                                .row.sortIdx]['okSpot'] = 0;
                                            // controller.lstDgvSpotsList.refresh();
                                          } else if (event.cell.column.field
                                                  .toString() ==
                                              'spoT_RATE') {
                                            await controller
                                                .doubleClickFilterGrid(
                                                    controller.dvgSpotGrid);
                                            await controller
                                                .doubleClickFilterGrid1(
                                                    controller
                                                        .dgvDealEntriesGrid,
                                                    'costPer10Sec',
                                                    num.parse(event.cell.value
                                                        .toString()));
                                          } else if (event.cell.column.field
                                                  .toString() ==
                                              'tapE_ID') {
                                            controller.tapeIdDilogBox();
                                          }
                                        },
                                        doPasccal: true,
                                        // columnAutoResize: false,
                                        widthSpecificColumn:
                                            Get.find<HomeController>()
                                                .getGridWidthByKey(
                                                    userGridSettingList:
                                                        controller
                                                            .userGridSetting1,
                                                    key: "tbl2"),
                                        keyMapping: const {
                                          "station": "STATION",
                                          "acT_DT": "ACT_DT",
                                          "stime": "STIME",
                                          "etime": "ETIME",
                                          "program": "PROGRAM",
                                          "fpcstart": "FPCSTART",
                                          "fpcprogram": "FPCPROGRAM",
                                          "tapE_ID": "TAPE_ID",
                                          "commercialcaption":
                                              "COMMERCIALCAPTION",
                                          "dur": "DUR",
                                          "commercialduration":
                                              "COMMERCIALCAPTION",
                                          "brand": "BRAND",
                                          "commCaption": "CommCaption",
                                          "pmtType": "PMTType",
                                          "schD_ID": "SCHD_ID",
                                          "spoT_STATUS": "SPOT_STATUS",
                                          "dealno": "DEALNO",
                                          "dealrow": "DEALROW",
                                          "amount": "AMOUNT",
                                          "spoT_RATE": "SPOT_RATE",
                                          "fctok": "FCTOK",
                                          "dealOK": "DealOK",
                                          "clienT_NAME": "CLIENT_NAME",
                                          "endTime": "EndTime",
                                          "nO_SPOT": "NO_SPOT",
                                          "okSpot": "OKSpot",
                                          "programcategoryname":
                                              "PROGRAMCATEGORYNAME",
                                          "groupcode": "GROUPCODE",
                                          "rO_NUM": "RO_NUM",
                                          "rO_DATE": "RO_DATE",
                                          "statioN_ID": "STATION_ID",
                                          "clienT_ID": "CLIENT_ID",
                                          "noProgram": "NoProgram",
                                          "brandName": "BrandName",
                                          "branD_ID": "BRAND_ID",
                                          "sEgmentNumber": "SEgmentNumber",
                                          "programCode": "ProgramCode",
                                          "pEndTime": "PEndTime",
                                        },
                                      ),
                                    ),
                                  ),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: GetBuilder<HomeController>(
                              id: "buttons",
                              init: Get.find<HomeController>(),
                              builder: (controllerX) {
                                PermissionModel formPermissions =
                                    Get.find<MainController>()
                                        .permissionList!
                                        .lastWhere((element) =>
                                            element.appFormName ==
                                            "frmXMLROEntry");
                                if (controllerX.buttons != null) {
                                  return Wrap(
                                    spacing: 5,
                                    runSpacing: 15,
                                    alignment: WrapAlignment.end,
                                    children: [
                                      for (var btn in controllerX.buttons!) ...{
                                        if (btn["name"].toString() ==
                                                "Search" ||
                                            btn["name"].toString() == "Delete")
                                          ...{}
                                        else ...{
                                          FormButtonWrapper(
                                            btnText: btn["name"],
                                            callback: Utils.btnAccessHandler2(
                                                        btn['name'],
                                                        controllerX,
                                                        formPermissions) ==
                                                    null
                                                ? null
                                                : () => formHandler(
                                                      btn['name'],
                                                    ),
                                            showIcon: false,
                                          ),
                                        }
                                      },
                                      for (var btn
                                          in maincontroller.extraButtons) ...{
                                        FormButtonWrapper(
                                          btnText: btn,
                                          callback: () => formHandler(btn),
                                          showIcon: false,
                                        ),
                                      },
                                      colorBox("NO Tape", Colors.pink[300],
                                          Colors.white),
                                      colorBox("Kill Date", Colors.white,
                                          Colors.black),
                                      colorBox("Language", Colors.red[700],
                                          Colors.white),
                                      colorBox("Revenue Type",
                                          Colors.yellow[700], Colors.white),
                                      InkWell(
                                        onTap: () {
                                          print("Campaign");
                                          maincontroller.exportToExcel();
                                        },
                                        child: colorBox("Campaign",
                                            Colors.white, Colors.black),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible:
                                              controller.isEnterNewPDC.value,
                                          child: DropDownField
                                              .formDropDown1WidthMap(
                                            controller.newPdcList.value,
                                            (data) {
                                              controller.selectedPdc = data;
                                            },
                                            "",
                                            .10,
                                            dialogHeight: 150,
                                            showtitle: false,
                                            selected: controller.selectedPdc,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible:
                                              controller.isEnterNewPDC.value,
                                          child: FormButtonWrapper(
                                            btnText: "Enter new PDC",
                                            callback: () {
                                              // maincontroller.getFillPDC();
                                              controller.pdcActivityPeriodTEC
                                                      .text =
                                                  controller.bookingNo1TEC.text;
                                              enterNewPdcDilogBox();
                                            },
                                            showIcon: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Container(
                                  child: Text("No"),
                                );
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  formHandler(btn) {
    switch (btn) {
      case "Info":
        infoDilogBox();
        break;
      case "Check All":
        // if (maincontroller.isCheckAll) {
        maincontroller.checkAll();
        // } else {
        //   LoadingDialog.callInfoMessage('All spots are booked.');
        // }
        break;
      case "MG Spots":
        maincontroller.mgSpotsDilogBox();
        break;
      case "Tape Id":
        maincontroller.tapId();
        break;
      case "Clear":
        Get.delete<EdiRoBookingController>();
        Get.find<HomeController>().clearPage1();

        break;
      case "Refresh":
        Get.delete<EdiRoBookingController>();
        Get.find<HomeController>().clearPage1();

        break;
      case "Save":
        maincontroller.save();

        break;
      case "Exit":
        print("Im in Exit");
        try {
          Get.find<HomeController>().postUserGridSetting1(listStateManager: [
            maincontroller.dgvDealEntriesGrid,
            maincontroller.dvgSpotGrid,
            maincontroller.mgSpotTabelGrid,
          ], tableNamesList: [
            'tbl1',
            'tbl2',
            'tbl3',
          ]);
        } catch (e) {
          print("Exit Error ===>" + e.toString());
        }

        break;
      case "Docs":
        Get.defaultDialog(
          title: "Documents",
          content: CommonDocsView(
            documentKey:
                "RObooking ${maincontroller.selectedLoactions!.key}${maincontroller.selectedChannel!.key}${maincontroller.bookingNo1TEC.text}${maincontroller.bookingNo2TEC.text}",
          ),
        ).then((value) {
          Get.delete<CommonDocsController>(tag: "commonDocs");
        });
        break;
    }
  }

  Container colorBox(text, color, textColor) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
        child: Text(
          text,
          style:
              TextStyle(color: textColor, fontSize: SizeDefine.fontSizeButton),
        ),
      ),
    );
  }

  // formHandler(String btnName) {
  //   print(btnName);
  //   if (btnName == "Clear") {
  //     Get.delete<EdiRoBookingController>();
  //     Get.find<HomeController>().clearPage1();
  //   } else if (btnName == "Save") {
  //     // saveValidate();
  //     enterNewPdcDilogBox();
  //   } else if (btnName == "Docs") {
  //     Get.defaultDialog(
  //       title: "Documents",
  //       content: CommonDocsView(
  //         documentKey:
  //             "RObooking${maincontroller.selectedLoactions!.key}${maincontroller.selectedChannel!.key}${maincontroller.bookingNo1TEC.text}${maincontroller.bookingNo2TEC.text}",
  //       ),
  //     ).then((value) {
  //       Get.delete<CommonDocsController>(tag: "commonDocs");
  //     });
  //     // maincontroller.docs();
  //   }
  // }

  infoDilogBox() {
    maincontroller.valueKey = ValueKey("infoDilogBox");
    maincontroller.drgabbleDialog.value = Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          print("true");
          maincontroller.drgabbleDialog.value = null;
        }
        return KeyEventResult.ignored;
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        borderOnForeground: false,
        margin: const EdgeInsets.all(0),
        child: Container(
          height: Get.height * .50,
          width: Get.width * .45,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => Container(
                    decoration: maincontroller.infoTableList.isEmpty
                        ? BoxDecoration(border: Border.all(color: Colors.grey))
                        : null,
                    child: maincontroller.infoTableList.value.isEmpty
                        ? null
                        : DataGridShowOnlyKeys(
                            mapData: maincontroller.infoTableList.value,
                            hideCode: false,
                            exportFileName: "EDI R.O. Booking",
                            onload: (load) {
                              load.stateManager
                                  .setSelectingMode(PlutoGridSelectingMode.row);
                              load.stateManager.setCurrentCell(
                                  load.stateManager.firstCell, 0);
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FormButton(
                    btnText: "Done",
                    callback: () {
                      maincontroller.drgabbleDialog.value = null;
                    },
                    showIcon: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  enterNewPdcDilogBox() {
    maincontroller.drgabbleDialog.value = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      borderOnForeground: false,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: Get.height * .80,
        width: Get.width * .50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        maincontroller.drgabbleDialog.value = null;
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
                FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Wrap(
                    spacing: Get.width * 0.005,
                    runSpacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      InputFields.formField1(
                        hintTxt: "Loaction",
                        controller: maincontroller.pdcLoactionTEC,
                        width: 0.24,
                        isEnable: false,
                      ),
                      InputFields.formField1(
                        hintTxt: "Channel",
                        controller: maincontroller.pdcChannelTEC,
                        width: 0.24,
                        isEnable: false,
                      ),
                      InputFields.formField1(
                        hintTxt: "Client",
                        controller: maincontroller.pdcClientTEC,
                        width: 0.24,
                        isEnable: false,
                      ),
                      InputFields.formField1(
                        hintTxt: "Agency",
                        controller: maincontroller.pdcAgencyTEC,
                        width: 0.24,
                        isEnable: false,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(1),
                            child: InputFields.formField1(
                              hintTxt: "Activity Period",
                              controller: maincontroller.pdcActivityPeriodTEC,
                              width: 0.075,
                              autoFocus: true,
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            "[YYYYMM]",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      ),
                      Container(
                        width: Get.width * 0.53,
                        height: 1,
                        color: Colors.grey,
                      ),
                      FocusTraversalOrder(
                        order: const NumericFocusOrder(2),
                        child: InputFields.formField1(
                          hintTxt: "Cheque NO",
                          controller: maincontroller.pdcChequeNoTEC,
                          width: 0.11,
                        ),
                      ),
                      DateWithThreeTextField(
                        title: "Chq Dt",
                        mainTextController: maincontroller.pdcChqDtTEC,
                        widthRation: .11,
                      ),
                      InputFields.numbers4(
                        hintTxt: "Chq Amt",
                        padLeft: 0,
                        controller: maincontroller.pdcChqAmtTEC,
                        width: 0.11,
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                      InputFields.formField1(
                        hintTxt: "Bank",
                        controller: maincontroller.pdcBankTEC,
                        width: 0.11,
                      ),
                      InputFields.formField1(
                        hintTxt: "Cheq Recd by",
                        controller: maincontroller.pdcChequeRecordByTEC,
                        width: 0.15,
                      ),
                      DateWithThreeTextField(
                        title: "Recd On",
                        mainTextController: maincontroller.pdcRecordOnTEC,
                        widthRation: .15,
                      ),
                      InputFields.formField1(
                        hintTxt: "Remarks",
                        controller: maincontroller.pdcRemarksTEC,
                        width: 0.15,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: FormButtonWrapper(
                          btnText: "Add",
                          callback: () {
                            maincontroller.fillGridAddData();
                          },
                          showIcon: false,
                        ),
                      ),
                      Obx(
                        () => maincontroller.fillPDCList.isEmpty
                            ? Container(
                                height: Get.height * 0.19,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                              )
                            : SizedBox(
                                height: Get.height * 0.19,
                                child: DataGridShowOnlyKeys(
                                  formatDate: false,
                                  mapData: maincontroller.fillPDCList.value,
                                  hideCode: false,
                                  exportFileName: "EDI R.O. Booking",
                                  onload: (load) {
                                    maincontroller.fillPDCTabelGrid =
                                        load.stateManager;
                                    load.stateManager.setSelectingMode(
                                        PlutoGridSelectingMode.row);
                                    load.stateManager.setCurrentCell(
                                        load.stateManager.firstCell, 0);
                                  },
                                  colorCallback: (row) => row.row.cells
                                          .containsValue(maincontroller
                                              .fillPDCTabelGrid?.currentCell)
                                      ? Colors.deepPurple.shade100
                                      : Colors.white,
                                  onRowDoubleTap: (event) {
                                    maincontroller.fillPDCTabelGrid
                                        ?.setCurrentCell(
                                            event.cell, event.rowIdx);
                                    var gridValue = event.row.cells;
                                    maincontroller.pdcChequeNoTEC.text =
                                        gridValue['chqNo']?.value;
                                    maincontroller.pdcChqDtTEC.text =
                                        gridValue['chqDate']?.value;
                                    maincontroller.pdcChqAmtTEC.text =
                                        gridValue['chqAmount']?.value;
                                    maincontroller.pdcBankTEC.text =
                                        gridValue['bankName']?.value;
                                    maincontroller.pdcChequeRecordByTEC.text =
                                        gridValue['chequeReceviedBy']?.value;
                                    maincontroller.pdcRecordOnTEC.text =
                                        gridValue['chequeReceviedOn']?.value;
                                    maincontroller.pdcRemarksTEC.text =
                                        gridValue['remarks']?.value;

                                    // print(event.row.cells['chqNo']?.value);
                                    // print(event.cell.column.field);
                                  },
                                ),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormButtonWrapper(
                            btnText: "Save",
                            callback: () {
                              maincontroller.saveClientPDC();
                            },
                            showIcon: false,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FormButtonWrapper(
                            btnText: "Clear",
                            callback: () {
                              maincontroller.clearFillPdc();
                            },
                            showIcon: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
