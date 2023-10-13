import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../providers/SizeDefine.dart';
import '../controllers/dealvs_r_o_data_report_controller.dart';

class DealvsRODataReportView extends GetView<DealvsRODataReportController> {
  DealvsRODataReportController controller =
      Get.put(DealvsRODataReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Card(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 5,
                spacing: 5,
                children: [
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(1),
                    child: DropDownField.formDropDown1WidthMap(
                      [],
                      (value) {},
                      "Location",
                      0.17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(2),
                    child: DropDownField.formDropDown1WidthMap(
                      [],
                      (value) {},
                      "Channel",
                      0.17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(3),
                    child: DateWithThreeTextField(
                      title: "From",
                      splitType: "-",
                      widthRation: 0.12,
                      // isEnable: controller.isEnable.value,
                      onFocusChange: (data) async {
                        // LoadingDialog.call();
                        // await controller.loadAsrunData();
                        // await controller.loadviewFPCData();
                        // Get.back();
                      },

                      mainTextController: controller.fromdDate,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(4),
                    child: DateWithThreeTextField(
                      title: "To",
                      splitType: "-",
                      widthRation: 0.12,
                      // isEnable: controller.isEnable.value,
                      onFocusChange: (data) async {
                        // LoadingDialog.call();
                        // await controller.loadAsrunData();
                        // await controller.loadviewFPCData();
                        // Get.back();
                      },
                      mainTextController: controller.toDate,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(5),
                    child: DropDownField.formDropDown1WidthMap(
                      [],
                      (value) {},
                      "Client",
                      0.17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(6),
                    child: DropDownField.formDropDown1WidthMap(
                      [],
                      (value) {},
                      "Deal No",
                      0.17,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Obx(() => Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: controller.dataTypes
                            .map((e) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio(
                                        value: e,
                                        groupValue:
                                            controller.currentType.value,
                                        onChanged: (value) {
                                          controller.currentType.value = e;
                                        }),
                                    Text(e),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ))
                            .toList(),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  FormButtonWrapper(
                    btnText: "Clear",
                    callback: () {
                      // controller.showBtnData();
                    },
                    showIcon: false,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(7),
                    child: FormButtonWrapper(
                      btnText: "Retrieve",
                      callback: () {
                        // controller.showBtnData();
                      },
                      showIcon: false,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Deal wise data showing.",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: SizeDefine.fontSizeInputField),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
                // color: Colors.amber,
                ))
      ],
    ));
  }
}
