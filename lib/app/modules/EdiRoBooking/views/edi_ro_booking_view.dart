import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/data/PermissionModel.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/LoadingScreen.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../providers/Utils.dart';
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
                              SizedBox(
                                  width: Get.width * 0.08,
                                  child: FormButtonWrapper(
                                      btnText: "Show & Link")),
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
                                  controller.agencyLeave();
                                },
                                "Agency",
                                .22,
                                selected: controller.selectedAgency,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Deal No",
                                .105,
                              ),
                              InputFields.formField1(
                                  hintTxt: "",
                                  controller: TextEditingController(),
                                  width: 0.105,
                                  isEnable: false),
                              DropDownField.formDropDown1WidthMap(
                                  controller.brand.value, (data) {
                                controller.selectedBrand = data;
                              }, "Brand", .22,
                                  autoFocus: true,
                                  selected: controller.selectedBrand),
                              DateWithThreeTextField(
                                title: "Start Date",
                                mainTextController: TextEditingController(),
                                widthRation: .105,
                                isEnable: false,
                              ),
                              DateWithThreeTextField(
                                title: "End Date",
                                mainTextController: TextEditingController(),
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
                                controller: TextEditingController(),
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
                                      controller: controller.bookedAmountTEC,
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
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.25,
                  child: DataGridFromMap(
                    mapData: [
                      {
                        "dsad": "dsadsa",
                        "Dsadsa": "dsadsa",
                      }
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: DataGridFromMap(
                    mapData: const [
                      {
                        "dsad": "dsadsa",
                        "Dsadsa": "dsadsa",
                      }
                    ],
                  ),
                )),
                // GetBuilder<HomeController>(
                //     id: "buttons",
                //     init: Get.find<HomeController>(),
                //     builder: (btncontroller) {
                //       if (btncontroller.buttons != null) {
                //         return Container(
                //           padding: EdgeInsets.only(top: 5),
                //           height: 40,
                //           child: Wrap(
                //             spacing: 5,
                //             runSpacing: 15,
                //             crossAxisAlignment: WrapCrossAlignment.end,
                //             alignment: WrapAlignment.start,
                //             // mainAxisSize: MainAxisSize.min,
                //             children: [
                //               for (var btn in btncontroller.buttons!) ...{
                //                 FormButtonWrapper(
                //                     btnText: btn["name"], callback: () {}
                //                     //  ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                //                     //     ? null
                //                     //     : () => controller.formHandler(btn['name']),
                //                     )
                //               },
                //               // for (var btn in btncontroller.buttons!)
                //               //   FormButtonWrapper(
                //               //     btnText: btn["name"],
                //               //     callback: () => controller.formHandler(btn['name'].toString()),
                //               //   ),
                //             ],
                //           ),
                //         );
                //       }
                //       return Container();
                //     }),
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
                            alignment: WrapAlignment.center,
                            children: [
                              for (var btn in controllerX.buttons!)
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
                                            )),
                              FormButtonWrapper(
                                btnText: "Info",
                                callback: () {
                                  infoDilogBox();
                                },
                                showIcon: false,
                              ),
                              FormButtonWrapper(
                                btnText: "Check All",
                                callback: () {},
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
                                callback: () {},
                                showIcon: false,
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

  formHandler(String btnName) {
    print(btnName);
    if (btnName == "Clear") {
      Get.delete<EdiRoBookingController>();
      Get.find<HomeController>().clearPage1();
    } else if (btnName == "Save") {
      // saveValidate();
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
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                        child: Text(
                          maincontroller.programList[index].toString(),
                          style:
                              TextStyle(fontSize: SizeDefine.dropDownFontSize),
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
                    mainTextController: TextEditingController(),
                    widthRation: .12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: TextEditingController(),
                    widthRation: .12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FormButton(
                    btnText: "Show",
                    callback: () {
                      maincontroller.drgabbleDialog.value = null;
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
