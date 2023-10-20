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
                                autoFocus: true,
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
                                },
                                "Location",
                                .22,
                                selected: controller.selectedLoactions,
                                autoFocus: true,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Channel",
                                .22,
                                autoFocus: true,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.client.value,
                                (data) {
                                  controller.selectedClient = data;
                                },
                                "Client",
                                .22,
                                selected: controller.selectedClient,
                                autoFocus: true,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.agency.value,
                                (data) {},
                                "Agency",
                                .22,
                                selected: controller.selectedAgency,
                                autoFocus: true,
                                isEnable: controller.isEnable.value,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Deal No",
                                .105,
                                autoFocus: true,
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
                                controller: TextEditingController(),
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
                                controller: TextEditingController(),
                                width: 0.05,
                              ),
                              InputFields.formField1(
                                hintTxt: "Pay Route",
                                isEnable: false,
                                controller: TextEditingController(),
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
                                      controller: TextEditingController(),
                                      width: 0.075,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      controller: TextEditingController(),
                                      width: 0.02,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      controller: TextEditingController(),
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
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Dur",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Amt",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        isEnable: false,
                                        controller: TextEditingController(),
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
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Pre. B Amt",
                                        isEnable: false,
                                        controller: TextEditingController(),
                                        width: 0.05,
                                      ),
                                      Container(
                                        width: Get.width * 0.105,
                                        child: FormButtonWrapper(
                                          showIcon: true,
                                          iconDataM:
                                              Icons.video_collection_rounded,
                                          btnText: "Show Programs",
                                          callback: () {},
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.105,
                                        child: FormButtonWrapper(
                                          showIcon: true,
                                          iconDataM: Icons.done_outline_rounded,
                                          btnText: "Mark Done",
                                          callback: () {},
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
                                      controller: TextEditingController(),
                                      width: 0.05,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "Booked Amount",
                                      isEnable: false,
                                      controller: TextEditingController(),
                                      width: 0.05,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "Val Amount",
                                      isEnable: false,
                                      controller: TextEditingController(),
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
                                        : () {}),
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
                  margin: const EdgeInsets.only(bottom: 8),
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
                      maincontroller.drgabbleDialog.value = null;
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
                  margin: const EdgeInsets.only(bottom: 8),
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
