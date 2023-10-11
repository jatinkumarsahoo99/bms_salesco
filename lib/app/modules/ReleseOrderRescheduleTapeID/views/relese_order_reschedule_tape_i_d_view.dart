import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/app/routes/app_pages.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/relese_order_reschedule_tape_i_d_controller.dart';

class ReleseOrderRescheduleTapeIDView extends StatelessWidget {
  const ReleseOrderRescheduleTapeIDView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReleseOrderRescheduleTapeIDController>(
        init: Get.put(ReleseOrderRescheduleTapeIDController()),
        builder: (controller) {
          return SizedBox(
            width: context.devicewidth,
            height: context.deviceheight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Controlls
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    // runAlignment: WrapAlignment.end,
                    // alignment: WrapAlignment.end,
                    children: [
                      DropDownField.formDropDown1WidthMap(
                          [], (p0) => null, "Location", .12),
                      DropDownField.formDropDown1WidthMap(
                          [], (p0) => null, "Channel", .12),
                      DropDownField.formDropDown1WidthMap(
                          [], (p0) => null, "Client", .12),
                      DropDownField.formDropDown1WidthMap(
                          [], (p0) => null, "Brand", .12),
                      DropDownField.formDropDown1WidthMap(
                          [], (p0) => null, "Tape Code", .12),
                      InputFields.formField1(
                        hintTxt: "TapeCode Duration",
                        controller: TextEditingController(),
                      ),
                      Row(),
                      DateWithThreeTextField(
                          title: "Eff. From Date",
                          widthRation: .12,
                          mainTextController: TextEditingController()),
                      DateWithThreeTextField(
                          widthRation: .12,
                          title: "Eff. To Date",
                          mainTextController: TextEditingController()),
                      FormButton(
                        btnText: "Search",
                        callback: () {},
                      ),
                      FormButton(
                        btnText: "Clear",
                        callback: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Data table
                  Expanded(
                    child: DataGridFromMap3(
                      mapData: controller.dataTableList,
                    ),
                  ),
                  const SizedBox(height: 5),

                  /// Common Buttons
                  Get.find<HomeController>()
                      .getCommonButton<ReleseOrderRescheduleTapeIDController>(
                          Routes.COMMERCIAL_CREATION_AUTO, (formName) {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  formhandler(String btnName) {
    switch (btnName) {
      case "Clear":
        break;
    }
  }
}
