import 'dart:html';

import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/data/PermissionModel.dart';
import 'package:bms_salesco/app/providers/DataGridMenu.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/app/providers/extensions/datagrid.dart';
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
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

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
          return Scaffold(
            floatingActionButton:
                Obx(() => controller.drgabbleDialog.value != null
                    ? DraggableFab(
                        child: controller.drgabbleDialog.value!,
                      )
                    : const SizedBox()),
            backgroundColor: Colors.grey[50],
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: Get.width * 0.45,
                          child: Wrap(
                            spacing: Get.width * 0.005,
                            runSpacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              DropDownField.formDropDown1WidthMap(
                                controller.fileNames.value,
                                (data) {
                                  controller.selectedFile = data;
                                  controller.effectiveDateLeave();
                                },
                                "Filename",
                                .445,
                                selected: controller.selectedFile,
                                isEnable: controller.isEnable.value,
                                autoFocus: true,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.strRoRefNo.value,
                                (data) {
                                  controller.selectedRoRefNo = data;
                                },
                                "RO Ref No",
                                .35,
                                selected: controller.selectedRoRefNo,
                                isEnable: controller.isEnable.value,
                              ),
                              Obx(
                                () => SizedBox(
                                  width: Get.width * 0.08,
                                  child: FormButtonWrapper(
                                    btnText: "Show & Link",
                                    callback: () {
                                      controller.showLink();
                                    },
                                    showIcon: false,
                                    isEnabled: controller.isShowLink.value,
                                  ),
                                ),
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.loactions.value,
                                (data) {
                                  controller.selectedLoactions = data;
                                  controller.locationLeave(data.key);
                                },
                                "Location",
                                .22,
                                selected: controller.selectedLoactions,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                  controller.channel.value, (data) {
                                controller.selectedChannel = data;
                              }, "Channel", .22,
                                  isEnable: controller.isEnable.value,
                                  selected: controller.selectedChannel),
                              DropDownField.formDropDown1WidthMap(
                                controller.client.value,
                                (data) {
                                  controller.selectedClient = data;
                                },
                                "Client",
                                .22,
                                selected: controller.selectedClient,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.agency.value,
                                (data) {
                                  // controller.agencyLeave();
                                },
                                "Agency",
                                .22,
                                selected: controller.selectedAgency,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                  controller.dealNo.value, (data) {
                                controller.selectedDealNo = data;
                                controller.dealLeave();
                              }, "Deal No", .105,
                                  dialogHeight: 250,
                                  selected: controller.selectedDealNo),
                              InputFields.formField1(
                                  hintTxt: "",
                                  controller: controller.dealTypeTEC,
                                  width: 0.105,
                                  isEnable: false),
                              Obx(
                                () => DropDownField.formDropDown1WidthMap(
                                  controller.brand.value,
                                  (data) {
                                    controller.selectedBrand = data;
                                    controller.brandLeave(data.key);
                                  },
                                  "Brand",
                                  .22,
                                  autoFocus: true,
                                  selected: controller.selectedBrand,
                                ),
                              ),
                              DateWithThreeTextField(
                                title: "Start Date",
                                mainTextController: controller.startDateTEC,
                                widthRation: .105,
                                isEnable: false,
                              ),
                              DateWithThreeTextField(
                                title: "End Date",
                                mainTextController: controller.endDateTEC,
                                widthRation: .105,
                                isEnable: false,
                              ),
                              InputFields.formField1(
                                hintTxt: "Zone",
                                isEnable: false,
                                controller: controller.zoneTEC,
                                width: 0.22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: SizedBox(
                          width: Get.width * 0.18,
                          child: Wrap(
                            spacing: Get.width * 0.005,
                            runSpacing: 5,
                            children: [
                              DateWithThreeTextField(
                                title: "Eff Date",
                                mainTextController: controller.effectiveDate,
                                widthRation: .12,
                              ),
                              DateWithThreeTextField(
                                title: "Bk. Date",
                                mainTextController: TextEditingController(),
                                widthRation: .12,
                              ),
                              InputFields.formField1(
                                hintTxt: "",
                                isEnable: false,
                                controller: controller.payRouteCodeTEC,
                                width: 0.05,
                              ),
                              InputFields.formField1(
                                hintTxt: "Pay Route",
                                isEnable: false,
                                controller: controller.payRouteTEC,
                                width: 0.18,
                              ),
                              InputFields.formField1(
                                hintTxt: "Pay Mode",
                                isEnable: false,
                                controller: controller.payModeTEC,
                                width: 0.18,
                              ),
                              SizedBox(
                                width: Get.width * 0.18,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InputFields.formField1(
                                      hintTxt: "Booking NO",
                                      controller: controller.bookingNo1TEC,
                                      width: 0.075,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      controller: controller.bookingNo2TEC,
                                      width: 0.02,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      controller: controller.bookingNo3TEC,
                                      width: 0.075,
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => DropDownField.formDropDown1WidthMap(
                                  controller.executives.value,
                                  (data) {
                                    controller.selectedExecutives = data;
                                  },
                                  "Executive",
                                  .18,
                                  selected: controller.selectedExecutives,
                                  autoFocus: true,
                                  dialogHeight: 250,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                        child: Padding(
                            padding: EdgeInsets.all(4),
                            child: SizedBox(
                                width: Get.width * 0.22,
                                child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    spacing: Get.width * 0.005,
                                    runSpacing: 5,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                              fontSize: SizeDefine.labelSize1),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                        child: Text(
                                          "Booked",
                                          style: TextStyle(
                                              fontSize: SizeDefine.labelSize1),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                        child: Text(
                                          "Balance",
                                          style: TextStyle(
                                              fontSize: SizeDefine.labelSize1),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                        child: Text(
                                          "Val Amount",
                                          style: TextStyle(
                                              fontSize: SizeDefine.labelSize1),
                                        ),
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Sport",
                                        isEnable: false,
                                        controller: controller.spotsAllTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.spotsBookedTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.spotsBalanceTEC,
                                        width: 0.05,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Dur",
                                        isEnable: false,
                                        controller: controller.durAllTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.durBookedTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.durBalanceTEC,
                                        width: 0.05,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Amt",
                                        isEnable: false,
                                        controller: controller.amtAllTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.amtBookedTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.amtBalanceTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: controller.amtValAmmountTEC,
                                        width: 0.05,
                                      ),
                                      Obx(
                                        () =>
                                            DropDownField.formDropDown1WidthMap(
                                          controller.positions.value,
                                          (data) {
                                            controller.selectedPositions = data;
                                          },
                                          "Position",
                                          .105,
                                          selected:
                                              controller.selectedPositions,
                                          autoFocus: true,
                                        ),
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Pre. V Amt",
                                        isEnable: false,
                                        controller: controller.preVAmtTEC,
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Pre. B Amt",
                                        isEnable: false,
                                        controller: controller.preBAmtTEC,
                                        width: 0.05,
                                      ),
                                      Container(
                                        width: Get.width * 0.105,
                                        child: FormButtonWrapper(
                                          showIcon: true,
                                          iconDataM:
                                              Icons.video_collection_rounded,
                                          btnText: "Show Programs",
                                          callback: () {
                                            showProgramDilogBox();
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.105,
                                        child: FormButtonWrapper(
                                          showIcon: true,
                                          iconDataM: Icons.done_outline_rounded,
                                          btnText: "Mark Done",
                                          callback: () {
                                            controller.onMarkAsDone();
                                          },
                                        ),
                                      ),
                                    ])))),
                    Column(
                      children: [
                        Card(
                            child: Padding(
                                padding: EdgeInsets.all(4),
                                child: SizedBox(
                                    width: Get.width * 0.07,
                                    child: Wrap(
                                      children: [
                                        InputFields.formField1(
                                          hintTxt: "Max Spend",
                                          isEnable: false,
                                          controller: controller.maxSpendTEC,
                                          width: 0.05,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "Booked Amount",
                                          isEnable: false,
                                          controller:
                                              controller.bookedAmountTEC,
                                          width: 0.05,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "Val Amount",
                                          isEnable: false,
                                          controller: controller.valAmountTEC,
                                          width: 0.05,
                                        ),
                                      ],
                                    )))),
                        const SizedBox(
                          height: 10,
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
                      ? Container(
                          height: Get.height * 0.25,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        )
                      : SizedBox(
                          height: Get.height * 0.25,
                          child: DataGridShowOnlyKeys(
                            mapData: controller.lstDgvDealEntriesList.value,
                            hideCode: false,
                            exportFileName: "EDI R.O. Booking",
                            onload: (load) {
                              controller.dgvDealEntriesGrid = load.stateManager;
                            },
                            colorCallback: (row) => row.row.cells.containsValue(
                                    controller.dgvDealEntriesGrid?.currentCell)
                                ? Colors.deepPurple.shade100
                                : Colors.white,
                            onRowDoubleTap: (event) {
                              controller.dgvDealEntriesGrid
                                  ?.setCurrentCell(event.cell, event.rowIdx);
                              print(event.cell.column.field);
                            },
                          ),
                        ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Obx(() => Expanded(
                      child: controller.lstDgvSpotsList.value.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            )
                          : Container(
                              child: DataGridShowOnlyKeys(
                                editKeys: ['noProgram'],
                                mapData: controller.lstDgvSpotsList.value,
                                hideCode: false,
                                formatDate: false,
                                exportFileName: "EDI R.O. Booking",
                                onload: (load) {
                                  load.stateManager.setCurrentCell(
                                      load.stateManager
                                          .getRowByIdx(
                                              controller.lastSelectedIdx)!
                                          .cells['program'],
                                      controller.lastSelectedIdx);
                                  // load.stateManager.moveCurrentCellByRowIdx(
                                  //     controller.lastSelectedIdx,
                                  //     PlutoMoveDirection.down);
                                  load.stateManager.scroll.vertical!.animateTo(
                                      controller.lastSelectedOffect,
                                      curve: Curves.ease,
                                      duration: Duration(milliseconds: 2));
                                  controller.dvgSpotGrid = load.stateManager;
                                },
                                colorCallback: (colorEvent) {
                                  colorEvent.row.cells.containsValue(
                                          controller.dvgSpotGrid?.currentCell)
                                      ? Colors.deepPurple.shade100
                                      : Colors.white;

                                  return controller.getColor(
                                      controller
                                          .lstDgvSpotsList[colorEvent.rowIdx],
                                      colorEvent.rowIdx);
                                },
                                onRowDoubleTap: (event) async {
                                  controller.lastSelectedOffect = controller
                                      .dvgSpotGrid!.scroll.verticalOffset;
                                  controller.lastSelectedIdx = event.rowIdx;
//Down Grid Set
                                  controller.dvgSpotGrid?.setCurrentCell(
                                      event.cell, event.rowIdx);
                                  //Clear
                                  if (Get.find<MainController>()
                                      .filters1
                                      .containsKey(controller
                                          .dgvDealEntriesGrid.hashCode
                                          .toString())) {
                                    await controller.clearFirstDataTableFilter(
                                        controller.dgvDealEntriesGrid!);
                                  }
                                  //Up Grid Set
                                  for (var element
                                      in controller.dgvDealEntriesGrid!.rows) {
                                    if (element.cells['costPer10Sec']?.value ==
                                        event.cell.value) {
                                      controller.dgvDealEntriesGrid
                                          ?.setCurrentCell(
                                              element.cells['costPer10Sec'],
                                              element.sortIdx);
                                      break;
                                    }
                                  }

                                  // print(event.cell.row.sortIdx);
                                  // print(event.cell.value);
                                  // print(event.cell.column.field);
                                  // print(event.row.cells['acT_DT']?.value);

                                  if (event.cell.column.field.toString() ==
                                      'fpcstart') {
                                    controller.spotFpcStart(
                                        controller.selectedLoactions?.key,
                                        controller.selectedChannel?.key,
                                        event.row.cells['acT_DT']?.value
                                            .toString());
                                  } else if (event.cell.column.field
                                          .toString() ==
                                      'program') {
                                    event.row.cells['noProgram']?.value = 1;
                                    event.row.cells['dealOK']?.value = "0";
                                    event.row.cells['fctok']?.value = "0";
                                    event.row.cells['okSpot']?.value = "0";

                                    controller
                                            .lstDgvSpotsList[event.row.sortIdx]
                                        ['noProgram'] = 1;
                                    controller
                                            .lstDgvSpotsList[event.row.sortIdx]
                                        ['dealOK'] = "0";
                                    controller
                                            .lstDgvSpotsList[event.row.sortIdx]
                                        ['fctok'] = "0";
                                    controller
                                            .lstDgvSpotsList[event.row.sortIdx]
                                        ['okSpot'] = "0";
                                    controller.lstDgvSpotsList.refresh();
                                  } else if (event.cell.column.field
                                          .toString() ==
                                      'spoT_RATE') {
                                    await controller.doubleClickFilterGrid(
                                        controller.dvgSpotGrid);
                                    await controller.doubleClickFilterGrid1(
                                        controller.dgvDealEntriesGrid,
                                        'costPer10Sec',
                                        event.cell.value.toString());
                                  } else if (event.cell.column.field
                                          .toString() ==
                                      'tapE_ID') {
                                    controller.tapeIdDilogBox();
                                  }
                                },
                              ),
                            ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controllerX) {
                        PermissionModel formPermissions =
                            Get.find<MainController>()
                                .permissionList!
                                .lastWhere((element) =>
                                    element.appFormName ==
                                    "frmnewbookingstatus");
                        if (controllerX.buttons != null) {
                          return Wrap(
                            spacing: 5,
                            runSpacing: 15,
                            alignment: WrapAlignment.end,
                            children: [
                              for (var btn in controllerX.buttons!)
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback: Utils.btnAccessHandler2(btn['name'],
                                              controllerX, formPermissions) ==
                                          null
                                      ? null
                                      : () => formHandler(
                                            btn['name'],
                                          ),
                                  showIcon: false,
                                ),
                              FormButtonWrapper(
                                btnText: "Info",
                                callback: () {
                                  infoDilogBox();
                                },
                                showIcon: false,
                              ),
                              FormButtonWrapper(
                                btnText: "Check All",
                                callback: () {
                                  controller.checkAll();
                                },
                                showIcon: false,
                              ),
                              FormButtonWrapper(
                                btnText: "MG Spots",
                                callback: () {
                                  mgSpotsDilogBox();
                                },
                                showIcon: false,
                              ),
                              FormButtonWrapper(
                                btnText: "Tape Id",
                                callback: () {
                                  controller.tapId();
                                },
                                showIcon: false,
                              ),
                              colorBox(
                                  "NO Tape", Colors.pink[300], Colors.white),
                              colorBox("Kill Date", Colors.white, Colors.black),
                              colorBox(
                                  "Language", Colors.red[700], Colors.white),
                              colorBox("Revenue Type", Colors.yellow[700],
                                  Colors.white),
                              colorBox("Campaign", Colors.white, Colors.black),
                              Obx(
                                () => Visibility(
                                  visible: controller.isEnterNewPDC.value,
                                  child: DropDownField.formDropDown1WidthMap(
                                    [],
                                    (data) {},
                                    "",
                                    .10,
                                    dialogHeight: 150,
                                    showtitle: false,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.isEnterNewPDC.value,
                                  child: FormButtonWrapper(
                                    btnText: "Enter new PDC",
                                    callback: () {
                                      // maincontroller.getFillPDC();
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  Container colorBox(text, color, textColor) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 6, bottom: 6),
        child: Text(
          text,
          style:
              TextStyle(color: textColor, fontSize: SizeDefine.fontSizeButton),
        ),
      ),
    );
  }

  formHandler(String btnName) {
    print(btnName);
    if (btnName == "Clear") {
      Get.delete<EdiRoBookingController>();
      Get.find<HomeController>().clearPage1();
    } else if (btnName == "Save") {
      // saveValidate();
      enterNewPdcDilogBox();
    } else if (btnName == "Docs") {
      Get.defaultDialog(
        title: "Documents",
        content: CommonDocsView(
          documentKey:
              "RObooking${maincontroller.selectedLoactions!.key}${maincontroller.selectedChannel!.key}${maincontroller.bookingNo1TEC.text}${maincontroller.bookingNo2TEC.text}",
        ),
      ).then((value) {
        Get.delete<CommonDocsController>(tag: "commonDocs");
      });
      // maincontroller.docs();
    }
  }

  showProgramDilogBox() {
    maincontroller.drgabbleDialog.value = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Container(
          height: Get.height * .50,
          width: Get.width * .20,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
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
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: maincontroller.programList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              maincontroller.selectedIndex.value = index;
                            },
                            onDoubleTap: () async {
                              maincontroller.selectedIndex.value = index;

                              if (maincontroller.lstDgvSpotsList.isNotEmpty) {
                                // Down Grid
                                if (Get.find<MainController>()
                                    .filters1
                                    .containsKey(maincontroller
                                        .dvgSpotGrid.hashCode
                                        .toString())) {
                                  await maincontroller
                                      .clearFirstDataTableFilter(
                                          maincontroller.dvgSpotGrid!);
                                }
                                for (var element
                                    in maincontroller.dvgSpotGrid!.rows) {
                                  maincontroller.dvgSpotGrid?.setCurrentCell(
                                      element.cells['spoT_RATE'],
                                      element.sortIdx);
                                  break;
                                }

                                await maincontroller.doubleClickFilterGrid1(
                                    maincontroller.dvgSpotGrid,
                                    'program',
                                    maincontroller.programList[index]
                                        .toString());

                                // UP Grid
                                if (Get.find<MainController>()
                                    .filters1
                                    .containsKey(maincontroller
                                        .dgvDealEntriesGrid.hashCode
                                        .toString())) {
                                  await maincontroller
                                      .clearFirstDataTableFilter(
                                          maincontroller.dgvDealEntriesGrid!);
                                }

                                for (var element in maincontroller
                                    .dgvDealEntriesGrid!.rows) {
                                  maincontroller.dgvDealEntriesGrid
                                      ?.setCurrentCell(
                                          element.cells['costPer10Sec'],
                                          element.sortIdx);
                                  break;
                                }
                                await maincontroller.doubleClickFilterGrid1(
                                    maincontroller.dgvDealEntriesGrid,
                                    'costPer10Sec',
                                    maincontroller.dvgSpotGrid!.rows[0]
                                        .cells['spoT_RATE']!.value
                                        .toString());
                              } else {
                                LoadingDialog.showErrorDialog(
                                    'Spot not found.');
                              }
                            },
                            child: Container(
                              color:
                                  (maincontroller.selectedIndex.value == index)
                                      ? Colors.deepPurpleAccent
                                      : Colors.white,
                              child: Text(
                                maincontroller.programList[index].toString(),
                                style: TextStyle(
                                    fontSize: SizeDefine.dropDownFontSize),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  infoDilogBox() {
    maincontroller.drgabbleDialog.value = Card(
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
    );
  }

  mgSpotsDilogBox() {
    if (maincontroller.selectedLoactions?.key == null) {
      LoadingDialog.showErrorDialog('Please select location.');
    } else if (maincontroller.selectedChannel?.key == null) {
      LoadingDialog.showErrorDialog('Please select channel.');
    } else if (maincontroller.selectedBrand?.key == null) {
      LoadingDialog.showErrorDialog('Please select brand.');
    } else {
      maincontroller.drgabbleDialog.value = Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        borderOnForeground: false,
        margin: const EdgeInsets.all(0),
        child: Container(
          height: Get.height * .65,
          width: Get.width * .80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    DateWithThreeTextField(
                      title: "From Date",
                      mainTextController: maincontroller.mgStartDateTEC,
                      widthRation: .12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DateWithThreeTextField(
                      title: "To Date",
                      mainTextController: maincontroller.mgEndDateTEC,
                      widthRation: .12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FormButton(
                      btnText: "Show",
                      callback: () {
                        maincontroller.showMakeGood();
                      },
                      showIcon: false,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FormButton(
                      btnText: "Back",
                      callback: () {
                        maincontroller.drgabbleDialog.value = null;
                      },
                      showIcon: false,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FormButton(
                      btnText: "Import & Mark",
                      callback: () {
                        maincontroller.pickFile();
                      },
                      showIcon: false,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
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
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  enterNewPdcDilogBox() {
    maincontroller.drgabbleDialog.value = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      borderOnForeground: false,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: Get.height * .82,
        width: Get.width * .50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        width: 0.15,
                      ),
                    ),
                    DateWithThreeTextField(
                      title: "Chq Dt",
                      mainTextController: maincontroller.pdcChqDtTEC,
                      widthRation: .15,
                    ),
                    InputFields.numbers4(
                      hintTxt: "Chq Amt",
                      padLeft: 0,
                      controller: maincontroller.pdcChqAmtTEC,
                      width: 0.15,
                      isNegativeReq: false,
                      inputformatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                    InputFields.formField1(
                      hintTxt: "Bank",
                      controller: maincontroller.pdcBankTEC,
                      width: 0.24,
                    ),
                    InputFields.formField1(
                      hintTxt: "Cheq Recd by",
                      controller: maincontroller.pdcChequeRecordByTEC,
                      width: 0.24,
                    ),
                    DateWithThreeTextField(
                      title: "Recd On",
                      mainTextController: maincontroller.pdcRecordOnTEC,
                      widthRation: .15,
                    ),
                    InputFields.formField1(
                      hintTxt: "Remarks",
                      controller: maincontroller.pdcRemarksTEC,
                      width: 0.33,
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
                              height: Get.height * 0.18,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            )
                          : SizedBox(
                              height: Get.height * 0.18,
                              child: DataGridShowOnlyKeys(
                                formatDate: false,
                                mapData: maincontroller.fillPDCList.value,
                                hideCode: false,
                                exportFileName: "EDI R.O. Booking",
                                onload: (load) {
                                  maincontroller.fillPDCTabelGrid =
                                      load.stateManager;
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
                          callback: () {},
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
    );
  }
}
