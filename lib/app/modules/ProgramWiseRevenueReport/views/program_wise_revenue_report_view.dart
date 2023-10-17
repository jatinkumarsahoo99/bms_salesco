import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../controllers/program_wise_revenue_report_controller.dart';

class ProgramWiseRevenueReportView
    extends GetView<ProgramWiseRevenueReportController> {
  const ProgramWiseRevenueReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Card(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              runSpacing: 5,
              spacing: 5,
              children: [
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Location",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Channel",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Program",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Clients",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Agency",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.listCheckBox,
                  (value) {
                    print(value);
                  },
                  "Revenue",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                const SizedBox(
                  width: 5,
                ),
                FocusTraversalOrder(
                  order: const NumericFocusOrder(3),
                  child: DateWithThreeTextField(
                    title: "From Date",
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
                    title: "To Date",
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
                Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: controller.bookingTypes
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                      value: e,
                                      groupValue: controller.bookingType.value,
                                      onChanged: (value) {
                                        controller.bookingType.value = e;
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
                FormButton(
                  btnText: "Genrate",
                  callback: () {
                    // controller.showBtnData();
                  },
                  showIcon: false,
                ),
                const SizedBox(
                  width: 5,
                ),
                FormButton(
                  btnText: "Program Summary",
                  callback: () {
                    // controller.showBtnData();
                  },
                  showIcon: false,
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        // GetBuilder<HomeController>(
        //     id: "buttons",
        //     init: Get.find<HomeController>(),
        //     builder: (btncontroller) {
        //       PermissionModel formPermissions = Get.find<MainController>()
        //           .permissionList!
        //           .lastWhere((element) {
        //         return element.appFormName == "frmNewBookingActivityReport";
        //       });
        //       if (btncontroller.buttons == null) {
        //         return Container();
        //       }
        //       return Card(
        //         margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(10),
        //               topRight: Radius.circular(10)),
        //         ),
        //         child: Container(
        //           width: Get.width,
        //           padding: const EdgeInsets.all(8.0),
        //           child: Wrap(
        //             spacing: 10,
        //             // buttonHeight: 20,
        //             alignment: WrapAlignment.start,
        //             // mainAxisSize: MainAxisSize.max,
        //             // pa
        //             children: [
        //               for (var btn in btncontroller.buttons!)
        //                 FormButtonWrapper(
        //                     btnText: btn["name"],
        //                     // isEnabled: btn['isDisabled'],
        //                     callback: Utils.btnAccessHandler2(btn['name'],
        //                                 btncontroller, formPermissions) ==
        //                             null
        //                         ? null
        //                         : () => Container()
        //                     // btnHnadler(btn['name']),
        //                     ),
        //             ],
        //           ),
        //         ),
        //       );
        //     }),
      ],
    ));
  }
}
