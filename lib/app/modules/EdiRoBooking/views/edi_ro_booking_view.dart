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

import '../controllers/edi_ro_booking_controller.dart';

class EdiRoBookingView extends StatelessWidget {
  EdiRoBookingView({Key? key}) : super(key: key);
  var maincontroller = Get.put<EdiRoBookingController>(EdiRoBookingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EdiRoBookingController>(
        init: maincontroller,
        id: "initData",
        builder: (controller) {
          print("init builder reload -${controller.initData == null}");
          if (controller.initData == null) {
            return PleaseWaitCard();
          }
          return Scaffold(
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
                                controller.initData?.softListMyFiles
                                    ?.map((e) => DropDownValue(key: e.convertedFileName, value: e.convertedFileName))
                                    .toList(),
                                (valeu) {
                                  controller.selectedFile = valeu;
                                  controller.effectiveDateLeave();
                                },
                                "Filename",
                                .445,
                                selected: controller.selectedFile,
                                autoFocus: true,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "RO Ref No",
                                .35,
                                autoFocus: true,
                              ),
                              SizedBox(width: Get.width * 0.08, child: FormButtonWrapper(btnText: "Show & Link")),
                              DropDownField.formDropDown1WidthMap(
                                controller.initData?.lstLocation?.map((e) => DropDownValue(key: e.locationCode, value: e.locationName)).toList(),
                                (valeu) {},
                                "Location",
                                .22,
                                autoFocus: true,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Channel",
                                .22,
                                autoFocus: true,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Client",
                                .22,
                                autoFocus: true,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Agency",
                                .22,
                                autoFocus: true,
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
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (valeu) {},
                                "Brand",
                                .22,
                                autoFocus: true,
                              ),
                              DateWithThreeTextField(
                                title: "Start Date",
                                mainTextController: TextEditingController(),
                                widthRation: .105,
                              ),
                              DateWithThreeTextField(
                                title: "End Date",
                                mainTextController: TextEditingController(),
                                widthRation: .105,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InputFields.formField1(
                                      hintTxt: "Booking NO",
                                      isEnable: false,
                                      controller: TextEditingController(),
                                      width: 0.075,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      isEnable: false,
                                      controller: TextEditingController(),
                                      width: 0.02,
                                    ),
                                    InputFields.formField1(
                                      hintTxt: "",
                                      isEnable: false,
                                      controller: TextEditingController(),
                                      width: 0.075,
                                    ),
                                  ],
                                ),
                              ),
                              DropDownField.formDropDown1WidthMap(
                                controller.initData?.executives?.map((e) => DropDownValue(key: e.personnelCode, value: e.personnelName)).toList(),
                                (valeu) {},
                                "Executive",
                                .18,
                                autoFocus: true,
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
                                child: Wrap(crossAxisAlignment: WrapCrossAlignment.end, spacing: Get.width * 0.005, runSpacing: 5, children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.width * 0.05,
                                    child: Text(
                                      "All",
                                      style: TextStyle(fontSize: SizeDefine.labelSize1),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.width * 0.05,
                                    child: Text(
                                      "Booked",
                                      style: TextStyle(fontSize: SizeDefine.labelSize1),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.width * 0.05,
                                    child: Text(
                                      "Balance",
                                      style: TextStyle(fontSize: SizeDefine.labelSize1),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.width * 0.05,
                                    child: Text(
                                      "Val Amount",
                                      style: TextStyle(fontSize: SizeDefine.labelSize1),
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
                                  DropDownField.formDropDown1WidthMap(
                                    controller.initData?.lstSpotPosType
                                        ?.map((e) => DropDownValue(key: e.spotPositionTypeCode, value: e.spotPositionTypeName))
                                        .toList(),
                                    (valeu) {},
                                    "Position",
                                    .105,
                                    selected: controller.selectedPromo,
                                    autoFocus: true,
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
                                      iconDataM: Icons.video_collection_rounded,
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
                    mapData: [
                      {
                        "dsad": "dsadsa",
                        "Dsadsa": "dsadsa",
                      }
                    ],
                  ),
                )),
                GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (btncontroller) {
                      if (btncontroller.buttons != null) {
                        return Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 15,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var btn in btncontroller.buttons!) ...{
                                FormButtonWrapper(btnText: btn["name"], callback: () {}
                                    //  ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                    //     ? null
                                    //     : () => controller.formHandler(btn['name']),
                                    )
                              },
                              // for (var btn in btncontroller.buttons!)
                              //   FormButtonWrapper(
                              //     btnText: btn["name"],
                              //     callback: () => controller.formHandler(btn['name'].toString()),
                              //   ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
              ],
            ),
          );
        });
  }
}
