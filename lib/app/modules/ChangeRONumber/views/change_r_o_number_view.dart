import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/change_r_o_number_controller.dart';

class ChangeRONumberView extends GetView<ChangeRONumberController> {
  const ChangeRONumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: context.width * .5,
          child: Dialog(
            // shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(20),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  backgroundColor: Colors.deepPurple,
                  title: const Text("Change RO Number"),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: context.width * .4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.locationList.value,
                          controller.handleOnChangedLocation,
                          "Location",
                          .18,
                          autoFocus: true,
                          selected: controller.selectedLocation,
                          inkWellFocusNode: controller.locationFN,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.channelList.value,
                          (val) => controller.selectedChannel = val,
                          "Channel",
                          .18,
                          selected: controller.selectedChannel,
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InputFields.formField1(
                  hintTxt: "Booking No",
                  controller: controller.bookingNoCtr,
                  width: .4,
                  maxLen: 10,
                ),
                SizedBox(height: 20),
                InputFields.formField1(
                  hintTxt: "Booking Reference No.",
                  controller: controller.bookingRefNumber,
                  width: .4,
                  maxLen: 999999,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 40,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        for (var btn in ["Change", "Clear", "Exit"]) ...{
                          FormButtonWrapper(
                            btnText: btn,
                            callback: () => controller.formHandler(btn),
                          )
                        },
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
