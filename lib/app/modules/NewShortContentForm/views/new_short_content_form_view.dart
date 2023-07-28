import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/dropdown.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_short_content_form_controller.dart';

class NewShortContentFormView extends GetView<NewShortContentFormController> {
  const NewShortContentFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width * .64,
        child: Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: const Text('New Short Content Form'),
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
                        controller.getChannel(value.key);
                        controller.selectedLocation = value;
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
                      controller.types.value,
                      (value) {
                        controller.selectedType = value;
                        controller.typeleave(value.key);
                      },
                      "Type",
                      .24,
                      autoFocus: true,
                    ),
                  ),
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.categeroies.value,
                      (value) {
                        controller.selectedCategory = value;
                      },
                      "Category",
                      .24,
                      autoFocus: true,
                    ),
                  ),
                  InputFields.formField1(
                    hintTxt: "Caption",
                    controller: controller.caption,
                    width: 0.24,
                  ),
                  InputFields.formField1(
                    hintTxt: "TX Caption",
                    controller: controller.txCaption,
                    width: 0.24,
                  ),
                  InputFields.formField1(
                    hintTxt: "House ID",
                    controller: controller.houseId,
                    focusNode: controller.houseFocusNode,
                    width: 0.155,
                  ),
                  DropDownField.formDropDownSearchAPI2(
                    GlobalKey(),
                    context,
                    title: "Program",
                    url: ApiFactory.NEW_SHORT_CONTENT_Program_Search,
                    onchanged: (value) {
                      controller.selectedProgram = value;
                    },
                    width: Get.width * 0.325,
                  ),
                  // InputFields.formField1(
                  //   hintTxt: "Program",
                  //   controller: TextEditingController(),
                  //   width: 0.325,
                  // ),
                  InputFields.formFieldNumberMask(
                      hintTxt: "SOM",
                      widthRatio: .155,
                      controller: TextEditingController(),
                      paddingLeft: 0),
                  InputFields.formFieldNumberMask(
                      hintTxt: "EOM",
                      widthRatio: .155,
                      controller: TextEditingController(),
                      paddingLeft: 0),
                  InputFields.formFieldNumberMask(
                      hintTxt: "Duration",
                      widthRatio: .16,
                      controller: TextEditingController(),
                      paddingLeft: 0),
                  DateWithThreeTextField(
                    title: "Start Date",
                    mainTextController: TextEditingController(),
                    widthRation: .155,
                  ),
                  DateWithThreeTextField(
                    title: "End Date",
                    mainTextController: TextEditingController(),
                    widthRation: .155,
                  ),
                  SizedBox(
                    width: Get.width * 0.16,
                    child: Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text(
                          "To be Billed",
                          style: TextStyle(fontSize: SizeDefine.labelSize1),
                        )
                      ],
                    ),
                  ),
                  InputFields.formField1(
                    hintTxt: "Remarks",
                    controller: TextEditingController(),
                    width: 0.49,
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
                                    btnText: btn["name"], callback: () {}
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
    );
  }
}
