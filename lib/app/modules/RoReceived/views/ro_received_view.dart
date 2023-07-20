import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ro_received_controller.dart';

class RoReceivedView extends GetView<RoReceivedController> {
   RoReceivedView({Key? key}) : super(key: key);
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
                  title: Text('RO Received'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  runSpacing: 5,
                  spacing: Get.width * 0.01,
                  children: [
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Location",
                      .24,
                      autoFocus: true,
                    ),
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Channel",
                      .24,
                      autoFocus: true,
                    ),
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Client",
                      .24,
                      autoFocus: true,
                    ),
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Agency",
                      .24,
                      autoFocus: true,
                    ),
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Brand",
                      .24,
                      autoFocus: true,
                    ),
                    InputFields.formField1(
                      hintTxt: "RO Number",
                      controller: TextEditingController(),
                      width: 0.24,
                    ),
                    DateWithThreeTextField(
                      title: "RO Rec. Date",
                      mainTextController: TextEditingController(),
                      widthRation: .115,
                    ),
                    DateWithThreeTextField(
                      title: "Eff. Date",
                      mainTextController: TextEditingController(),
                      widthRation: .115,
                    ),
                    InputFields.formField1(hintTxt: "Activity Month", controller: TextEditingController(), width: 0.24, isEnable: false),
                    InputFields.numbers(
                      hintTxt: "RO Amount",
                      padLeft: 0,
                      controller: TextEditingController(),
                      width: 0.115,
                    ),
                    InputFields.numbers(
                      padLeft: 0,
                      hintTxt: "Valuation RO Amount",
                      controller: TextEditingController(),
                      width: 0.115,
                    ),
                    InputFields.formField1(
                      hintTxt: "FCT",
                      controller: TextEditingController(),
                      width: 0.24,
                    ),
                    InputFields.formField1(
                      hintTxt: "Remarks",
                      controller: TextEditingController(),
                      width: 0.24,
                    ),
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(value: "1", groupValue: "1", onChanged: (value) {}),
                              Text(
                                "Additional",
                                style: TextStyle(fontSize: SizeDefine.labelSize1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(value: "2", groupValue: "1", onChanged: (value) {}),
                              Text(
                                "Cancellation",
                                style: TextStyle(fontSize: SizeDefine.labelSize1),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    DropDownField.formDropDown1WidthMap(
                      [],
                      (valeu) {},
                      "Revenue Type",
                      .24,
                      autoFocus: true,
                    ),
                  ],
                ),
                SizedBox(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
