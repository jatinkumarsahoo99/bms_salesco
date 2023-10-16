import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/booking_status_report_controller.dart';

class BookingStatusReportView extends GetView<BookingStatusReportController> {
  BookingStatusReportController controller =
      Get.put<BookingStatusReportController>(BookingStatusReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  controller.locations,
                  (value) {
                    print(value);
                  },
                  "Location",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.locations[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.channels,
                  (value) {
                    print(value);
                  },
                  "Channel",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.zone,
                  (value) {
                    print(value);
                  },
                  "Zone",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.clients,
                  (value) {
                    print(value);
                  },
                  "Clients",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.agency,
                  (value) {
                    print(value);
                  },
                  "Agency",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.revenue,
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
                    mainTextController: controller.fromDate,
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
                                        controller.getRadioStatus(e);
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
                    controller.genrate();
                  },
                  showIcon: false,
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        GetBuilder<HomeController>(
            id: "buttons",
            init: Get.find<HomeController>(),
            builder: (btncontroller) {
              if (btncontroller.buttons != null) {
                return Container(
                  padding: EdgeInsets.only(top: 5),
                  height: 40,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 15,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var btn in btncontroller.buttons!) ...{
                        FormButtonWrapper(
                          btnText: btn["name"],
                          callback: ((Utils.btnAccessHandler(btn['name'],
                                      controller.formPermissions!) ==
                                  null))
                              ? null
                              : () => controller.formHandler(btn['name']),
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
      ],
    ));
  }

  //   btnHnadler(btnName) {
  //   switch (btnName) {
  //     case "Refresh":
  //       controller.showBtnData();
  //       break;
  //     case "Exit":
  //       Get.find<HomeController>().postUserGridSetting2(listStateManager: [
  //         {"stateManager": controller.stateManager},
  //       ]);
  //       break;
  //     case "Clear":
  //       Get.delete<AuditStatusController>();
  //       Get.find<HomeController>().clearPage1();
  //       break;
  //     default:
  //       break;
  //   }
  // }
}
