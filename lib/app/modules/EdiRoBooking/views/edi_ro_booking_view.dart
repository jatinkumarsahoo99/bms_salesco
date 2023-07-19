import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edi_ro_booking_controller.dart';

class EdiRoBookingView extends GetView<EdiRoBookingController> {
  const EdiRoBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: Get.width * 0.45,
              child: Wrap(
                spacing: Get.width * 0.005,
                crossAxisAlignment: WrapCrossAlignment.end,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Filename",
                    .35,
                    autoFocus: true,
                  ),
                  SizedBox(width: Get.width * 0.08, child: FormButtonWrapper(btnText: "Open File")),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "RO Ref No",
                    .35,
                    autoFocus: true,
                  ),
                  SizedBox(width: Get.width * 0.08, child: FormButtonWrapper(btnText: "Show & Link")),
                  DropDownField.formDropDown1WidthMap(
                    [],
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
                    .115,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Deal No",
                    .115,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (valeu) {},
                    "Brand",
                    .22,
                    autoFocus: true,
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
