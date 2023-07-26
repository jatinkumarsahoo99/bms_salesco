import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/InputFields/normal_text_field.dart';
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: context.width * .48,
                  height: 50,
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurpleAccent.shade100,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Chage RO Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width * .4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListDropDown2(
                        title: "Location",
                        autoFocus: true,
                        widthRatio: .16,
                        items: [
                          DropDownValue(
                            key: "12",
                            value: "nitish",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish1",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish2",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish2",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish2",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish2",
                          ),
                          DropDownValue(
                            key: "12",
                            value: "nitish2",
                          ),
                        ],
                      ),

                      // Obx(() {
                      //   return DropDownField.formDropDown1WidthMap(
                      //     controller.locationList.value,
                      //     controller.handleOnChangedLocation,
                      //     "Location",
                      //     .16,
                      //     autoFocus: true,
                      //     selected: controller.selectedLocation,
                      //     inkWellFocusNode: controller.locationFN,
                      //   );
                      // }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.channelList.value,
                          (val) => controller.selectedChannel = val,
                          "Channel",
                          .16,
                          selected: controller.selectedChannel,
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // InputFields.formField1(
                //   hintTxt: "Booking No",
                //   controller: TextEditingController(),
                //   width: .4,
                // ),
                NormalTextField(
                  controller: controller.bookingNoCtr,
                  label: "Booking No",
                  widthRatio: .4,
                ),
                SizedBox(height: 20),
                NormalTextField(
                  controller: controller.bookingNoCtr,
                  label: "Booking Reference Number",
                  widthRatio: .4,
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
