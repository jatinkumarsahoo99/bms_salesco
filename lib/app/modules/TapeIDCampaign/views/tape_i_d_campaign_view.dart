import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/tape_i_d_campaign_controller.dart';

class TapeIDCampaignView extends GetView<TapeIDCampaignController> {
  const TapeIDCampaignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  InputFields.formField1(
                    hintTxt: "Enter Tape ID",
                    controller: TextEditingController(),
                    width: .15,
                    autoFocus: true,
                    padLeft: 0,
                  ),
                  InputFields.formFieldDisable1(hintTxt: "Activity Month", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Client", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Agency", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Brand", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Caption", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Duration", value: "value", widthRatio: .15, leftPad: 0),
                  InputFields.formFieldDisable1(hintTxt: "Agency Tape ID", value: "value", widthRatio: .15, leftPad: 0),
                  DateWithThreeTextField(title: "Start Date", mainTextController: TextEditingController(), widthRation: .15),
                  DateWithThreeTextField(title: "End Date", mainTextController: TextEditingController(), widthRation: .15),
                  InputFields.formFieldDisable1(hintTxt: "Created By", value: "value", widthRatio: .15, leftPad: 0),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CupertinoSlidingSegmentedControl(
                        onValueChanged: (value) {},
                        children: <int, Widget>{
                          0: Text(
                            'Location & Channel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeDefine.fontSizeTab,
                            ),
                          ),
                          1: Text(
                            'History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeDefine.fontSizeTab,
                            ),
                          ),
                        },
                        groupValue: 0,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// bottom common buttons
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (btncontroller) {
                      if (btncontroller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in btncontroller.buttons!) ...{
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                    ? null
                                    : () => controller.formHandler(btn['name']),
                              )
                            },
                          ],
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
