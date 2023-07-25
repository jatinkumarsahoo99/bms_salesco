import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/view_old_deal_controller.dart';

class ViewOldDealView extends GetView<ViewOldDealController> {
  const ViewOldDealView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(4.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 5,
                spacing: Get.width * 0.01,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Executive",
                    .23,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Location",
                    .23,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Channel",
                    .23,
                    autoFocus: true,
                  ),
                  DateWithThreeTextField(
                    title: "Date",
                    mainTextController: TextEditingController(),
                    widthRation: .23,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Client",
                    .23,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Agency",
                    .23,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "DealNo",
                    .23,
                    autoFocus: true,
                  ),
                  DateWithThreeTextField(
                    title: "DealPeriod From",
                    mainTextController: TextEditingController(),
                    widthRation: .11,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: TextEditingController(),
                    widthRation: .11,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InputFields.formField1(
                        hintTxt: "Deal Amount",
                        width: .155,
                        controller: TextEditingController(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InputFields.formField1(
                        hintTxt: "Total Deal Duration",
                        width: .155,
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FormButtonWrapper(btnText: "Clear"),
                      SizedBox(
                        width: 10,
                      ),
                      FormButtonWrapper(btnText: "Exit"),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
