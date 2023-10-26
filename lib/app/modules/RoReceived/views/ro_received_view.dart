import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/LoadingScreen1.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../CommonSearch/views/common_search_view.dart';
import '../controllers/ro_received_controller.dart';

class RoReceivedView extends StatelessWidget {
  RoReceivedView({Key? key}) : super(key: key);
  final maincontroller = Get.put<RoReceivedController>(RoReceivedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spot Position Type Master'),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: maincontroller,
          id: "main",
          builder: (controller) {
            return Center(
              child: SizedBox(
                width: Get.width * .64,
                child: Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppBar(
                        title: const Text('RO Received'),
                        centerTitle: true,
                        backgroundColor: Colors.deepPurple,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.locations != null
                          ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              runSpacing: 5,
                              spacing: Get.width * 0.01,
                              children: [
                                DropDownField.formDropDown1WidthMap(
                                  controller.locations,
                                  (value) {
                                    controller.selectedLocation = value;
                                    controller.getChannel(value.key);
                                  },
                                  "Location",
                                  .24,
                                  selected: controller.selectedLocation,
                                  autoFocus: true,
                                ),
                                Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                    controller.channels.value,
                                    (value) {
                                      controller.selectedChannel = value;
                                    },
                                    "Channel",
                                    .24,
                                    autoFocus: true,
                                  ),
                                ),
                                DropDownField.formDropDownSearchAPI2(
                                  GlobalKey(),
                                  Get.context!,
                                  title: "Client",
                                  url: ApiFactory.RO_RECEIVED_GET_CLIENTS,
                                  parseKeyForKey: "clientCode",
                                  parseKeyForValue: 'clientName',
                                  onchanged: (value) {
                                    controller.selectedClient = value;
                                    controller.clientLeave();
                                  },
                                  customInData: "clientList",
                                  selectedValue: controller.selectedClient,
                                  width: Get.width * .24,
                                ),
                                Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.agencies.value, (valeu) {
                                    controller.selectedAgency = valeu;
                                  }, "Agency", .24,
                                      autoFocus: true,
                                      selected: controller.selectedAgency),
                                ),
                                Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.brands.value, (valeu) {
                                    controller.selectedBrand = valeu;
                                  }, "Brand", .24,
                                      autoFocus: true,
                                      selected: controller.selectedBrand),
                                ),
                                InputFields.formField1(
                                  hintTxt: "RO Number",
                                  controller: controller.roNumber,
                                  width: 0.24,
                                  inputformatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                ),
                                DateWithThreeTextField(
                                  title: "RO Rec. Date",
                                  mainTextController: controller.roRecDate,
                                  widthRation: .115,
                                ),
                                DateWithThreeTextField(
                                  title: "Eff. Start Date",
                                  mainTextController: controller.effDate,
                                  onFocusChange: (date) {
                                    print(date);
                                    controller.activityMonth.text =
                                        date.split("-")[2] + date.split("-")[1];
                                    // controller.dateLeave(date);
                                  },
                                  widthRation: .115,
                                ),
                                DateWithThreeTextField(
                                  title: "Eff. End Date",
                                  mainTextController: controller.effEndDate,
                                  onFocusChange: (date) {},
                                  widthRation: .115,
                                ),
                                InputFields.formField1(
                                    hintTxt: "Activity Month",
                                    controller: controller.activityMonth,
                                    width: 0.24,
                                    isEnable: false),
                                InputFields.numbers4(
                                  hintTxt: "RO Amount",
                                  padLeft: 0,
                                  controller: controller.roAmount,
                                  width: 0.115,
                                  isNegativeReq: false,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                                InputFields.numbers4(
                                  padLeft: 0,
                                  hintTxt: "Valuation RO Amount",
                                  controller: controller.roValAmount,
                                  width: 0.115,
                                  isNegativeReq: false,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                                InputFields.formField1(
                                    hintTxt: "FCT",
                                    controller: controller.fct,
                                    width: 0.24,
                                    inputformatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ]),
                                InputFields.formField1(
                                    hintTxt: "Remarks",
                                    controller: controller.remark,
                                    width: 0.24,
                                    inputformatters: [
                                      UpperCaseTextFormatter(),
                                    ]),

                                Obx(() => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: controller.dataTypes
                                          .map((e) => Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Radio(
                                                      value: e,
                                                      groupValue: controller
                                                          .currentType.value,
                                                      onChanged: (value) {
                                                        controller.currentType
                                                            .value = e;
                                                        controller
                                                            .getRadioStatus(e);
                                                      }),
                                                  Text(e),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    )),
                                // Obx(
                                //   () => SizedBox(
                                //     width: Get.width * 0.24,
                                //     child: Row(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.end,
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             InkWell(
                                //               child: Icon(controller
                                //                       .additional.value
                                //                   ? Icons
                                //                       .radio_button_checked_outlined
                                //                   : Icons
                                //                       .radio_button_off_outlined),
                                //               onTap: () {
                                //                 controller.additional.value =
                                //                     true;
                                //               },
                                //             ),
                                //             const SizedBox(
                                //               width: 10,
                                //             ),
                                //             Text(
                                //               "Additional",
                                //               style: TextStyle(
                                //                   fontSize:
                                //                       SizeDefine.labelSize1),
                                //             ),
                                //           ],
                                //         ),
                                //         Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             InkWell(
                                //               child: Icon(!controller
                                //                       .additional.value
                                //                   ? Icons
                                //                       .radio_button_checked_outlined
                                //                   : Icons
                                //                       .radio_button_off_outlined),
                                //               onTap: () {
                                //                 controller.additional.value =
                                //                     false;
                                //               },
                                //             ),
                                //             const SizedBox(
                                //               width: 10,
                                //             ),
                                //             Text(
                                //               "Cancellation",
                                //               style: TextStyle(
                                //                   fontSize:
                                //                       SizeDefine.labelSize1),
                                //             )
                                //           ],
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 70,
                                ),
                                Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.revenueType.value, (valeu) {
                                    controller.selectedRevenue = valeu;
                                  }, "Revenue Type", .24,
                                      autoFocus: true,
                                      selected: controller.selectedRevenue),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: Get.height / 1.9,
                              // child: LoadingScreen1()
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.locations == null
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: GetBuilder<HomeController>(
                                  id: "buttons",
                                  init: Get.find<HomeController>(),
                                  builder: (btncontroller) {
                                    if (btncontroller.buttons != null) {
                                      return SizedBox(
                                        height: 40,
                                        child: Wrap(
                                          spacing: 5,
                                          runSpacing: 15,
                                          alignment: WrapAlignment.center,
                                          // alignment: MainAxisAlignment.start,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (var btn
                                                in btncontroller.buttons!)
                                              FormButtonWrapper(
                                                  btnText: btn["name"],
                                                  callback: () {
                                                    btnHandler(btn["name"]);
                                                  }
                                                  //  ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                                  //     ? null
                                                  //     : () => controller.formHandler(btn['name']),
                                                  )

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
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  btnHandler(save) {
    switch (save) {
      case "Save":
        maincontroller.validation();
        break;
      case "Clear":
        Get.delete<RoReceivedController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(SearchPage(
          screenName: "RO Received",
          strViewName: "BMS_vRoReceived",
          appBarName: "RO Received",
          isPopup: true,
          isAppBarReq: true,
          actionableSearch: true,
          actionableMap: {
            "RoReceivedCode": (value) {
              print(value);
              maincontroller.retriveData(value);
            }
          },
        ));
        break;
      case "Delete":
        maincontroller.deleteRoReceive();
        break;
      default:
    }
  }
}
