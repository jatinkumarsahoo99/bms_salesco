import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ro_received_controller.dart';

class RoReceivedView extends StatelessWidget {
  RoReceivedView({Key? key}) : super(key: key);
  final controller = Get.put<RoReceivedController>(RoReceivedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spot Position Type Master'),
        centerTitle: true,
      ),
      body: Center(
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
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  runSpacing: 5,
                  spacing: Get.width * 0.01,
                  children: [
                    Obx(
                      () => DropDownField.formDropDown1WidthMap(
                        controller.locations.value,
                        (value) {
                          controller.selectedLocation = value;
                          controller.getChannel(value.key);
                        },
                        "Location",
                        .24,
                        autoFocus: true,
                      ),
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
                    Obx(
                      () => DropDownField.formDropDown1WidthMap(
                        controller.clients.value,
                        (value) {
                          controller.selectedClient = value;
                          controller.clientLeave();
                        },
                        "Client",
                        .24,
                        autoFocus: true,
                      ),
                    ),
                    Obx(
                      () => DropDownField.formDropDown1WidthMap(
                        controller.agencies.value,
                        (valeu) {
                          controller.selectedAgency = valeu;
                        },
                        "Agency",
                        .24,
                        autoFocus: true,
                      ),
                    ),
                    Obx(
                      () => DropDownField.formDropDown1WidthMap(
                        controller.brands.value,
                        (valeu) {
                          controller.selectedBrand = valeu;
                        },
                        "Brand",
                        .24,
                        autoFocus: true,
                      ),
                    ),
                    InputFields.formField1(
                      hintTxt: "RO Number",
                      controller: controller.roNumber,
                      width: 0.24,
                    ),
                    DateWithThreeTextField(
                      title: "RO Rec. Date",
                      mainTextController: controller.roRecDate,
                      widthRation: .115,
                    ),
                    DateWithThreeTextField(
                      title: "Eff. Date",
                      mainTextController: controller.effDate,
                      onFocusChange: (date) {
                        print(date);
                        controller.activityMonth.text =
                            date.split("-")[2] + date.split("-")[1];
                        // controller.dateLeave(date);
                      },
                      widthRation: .115,
                    ),
                    InputFields.formField1(
                        hintTxt: "Activity Month",
                        controller: controller.activityMonth,
                        width: 0.24,
                        isEnable: false),
                    InputFields.numbers(
                      hintTxt: "RO Amount",
                      padLeft: 0,
                      controller: controller.roAmount,
                      width: 0.115,
                    ),
                    InputFields.numbers(
                      padLeft: 0,
                      hintTxt: "Valuation RO Amount",
                      controller: controller.roValAmount,
                      width: 0.115,
                    ),
                    InputFields.formField1(
                      hintTxt: "FCT",
                      controller: controller.fct,
                      width: 0.24,
                    ),
                    InputFields.formField1(
                      hintTxt: "Remarks",
                      controller: controller.remark,
                      width: 0.24,
                    ),
                    Obx(
                      () => SizedBox(
                        width: Get.width * 0.24,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(controller.additional.value
                                      ? Icons.radio_button_checked_outlined
                                      : Icons.radio_button_off_outlined),
                                  onTap: () {
                                    controller.additional.value = true;
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Additional",
                                  style: TextStyle(
                                      fontSize: SizeDefine.labelSize1),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(!controller.additional.value
                                      ? Icons.radio_button_checked_outlined
                                      : Icons.radio_button_off_outlined),
                                  onTap: () {
                                    controller.additional.value = false;
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cancellation",
                                  style: TextStyle(
                                      fontSize: SizeDefine.labelSize1),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => DropDownField.formDropDown1WidthMap(
                        controller.revenueType.value,
                        (valeu) {
                          controller.selectedRevenue = valeu;
                        },
                        "Revenue Type",
                        .24,
                        autoFocus: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
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
                                for (var btn in btncontroller.buttons!) ...{
                                  FormButtonWrapper(
                                      btnText: btn["name"],
                                      callback: () {
                                        btnHandler(btn["name"]);
                                      }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  btnHandler(save) {
    switch (save) {
      case "Save":
        controller.save();
        break;
      default:
    }
  }
}
