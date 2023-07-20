import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/change_r_o_number_controller.dart';

class ChangeRONumberView extends GetView<ChangeRONumberController> {
  const ChangeRONumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      DropDownField.formDropDown1WidthMap(
                        [],
                        (p0) {},
                        "Location",
                        .16,
                        autoFocus: true,
                      ),
                      DropDownField.formDropDown1WidthMap(
                        [],
                        (p0) => null,
                        "Channel",
                        .16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InputFields.formField1(
                  hintTxt: "Booking No",
                  controller: TextEditingController(),
                  width: .4,
                ),
                SizedBox(height: 20),
                InputFields.formField1(
                  hintTxt: "Booking Reference Number",
                  controller: TextEditingController(),
                  width: .4,
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
