import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';

import '../controllers/geo_program_update_controller.dart';

class GeoProgramUpdateView extends StatelessWidget {
   GeoProgramUpdateView({Key? key}) : super(key: key);

   GeoProgramUpdateController controllerX =
  Get.put<GeoProgramUpdateController>(GeoProgramUpdateController());

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
                    "Geo Program Update",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                DropDownField.formDropDown1WidthMap(
                  controllerX.locationList,
                        (value) {
                      controllerX.selectedLocation = value;
                    },
                  "Location",
                  .2,
                  autoFocus: true,
                    dialogHeight: Get.height * .35,
                  selected: controllerX.selectedLocation
                ),
                SizedBox(height: 20),
                DropDownField.formDropDown1WidthMap(
                    controllerX.channelList,
                        (value) {
                          controllerX.selectedChannel = value;
                    },
                  "Channel",
                  .2,
                    dialogHeight: Get.height * .35,
                    selected: controllerX.selectedChannel
                ),
                SizedBox(height: 20),
                DateWithThreeTextField(
                  title: "From Date",
                  mainTextController: controllerX.formDateController,
                  widthRation: 0.2,
                  startDate: DateTime.now(),
                ),
                SizedBox(height: 20),
                DateWithThreeTextField(
                  title: "To Date",
                  mainTextController: controllerX.toDateController,
                  widthRation: 0.2,
                  startDate: DateTime.now(),
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
                        for (var btn in ["Update", "Clear", "Exit"]) ...{
                          FormButtonWrapper(
                            btnText: btn,
                            callback: () => controllerX.formHandler(btn),
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
