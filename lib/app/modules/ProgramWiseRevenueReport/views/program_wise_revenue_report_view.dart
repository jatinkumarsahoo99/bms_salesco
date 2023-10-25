import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/program_wise_revenue_report_controller.dart';

class ProgramWiseRevenueReportView extends StatelessWidget {
  ProgramWiseRevenueReportView({Key? key}) : super(key: key);

  ProgramWiseRevenueReportController controller =
      Get.put<ProgramWiseRevenueReportController>(
          ProgramWiseRevenueReportController());
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
                  onChanged: (index, selectValue) {
                    controller.channels[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.programType,
                  (value) {
                    print(value);
                  },
                  "Program Type",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.programType[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.program,
                  (value) {
                    print(value);
                  },
                  "Program",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.program[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.zone,
                  (value) {
                    print(value);
                  },
                  "Zone",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.zone[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.revnue,
                  (value) {
                    print(value);
                  },
                  "Revune",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.revnue[index].isSelected = selectValue;
                  },
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controller.attribute,
                  (value) {
                    print(value);
                  },
                  "Attribute",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.attribute[index].isSelected = selectValue;
                  },
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
                                        controller.getRadioStatus(value!);
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
                const SizedBox(
                  width: 5,
                ),
                FormButton(
                  btnText: "Program Summary",
                  callback: () {
                    controller.showDilogBox();
                  },
                  showIcon: false,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Obx(
            () => Container(
              child: controller.dataTableList.value.isEmpty
                  ? null
                  : DataGridFromMap(
                      mapData: controller.dataTableList.value.map((e) {
                        /// details
                        if (controller.val && e['scheduletime'] != null) {
                          e['scheduletime'] = controller.timeFormat.format(
                              DateFormat('dd/MM/yyyy hh:mm:ss')
                                  .parse(e['scheduletime']));
                        }
                        if (controller.val && e['telecasttime'] != null) {
                          e['telecasttime'] = controller.timeFormat.format(
                              DateFormat('dd/MM/yyyy hh:mm:ss')
                                  .parse(e['telecasttime']));
                        }
                        if (controller.val && e['scheduledate'] != null) {
                          e['scheduledate'] = DateFormat('dd-MM-yyyy').format(
                              DateFormat('dd/MM/yyyy hh:mm:ss')
                                  .parse(e['scheduledate']));
                        }

                        /// Summary
                        if (!controller.val && e['telecasttime'] != null) {
                          e['telecasttime'] = controller.timeFormat.format(
                              DateFormat('dd/MM/yyyy hh:mm:ss')
                                  .parse(e['telecasttime']));
                        }

                        return e;
                      }).toList(),
                      hideCode: false,
                      formatDate: false,
                      exportFileName: "ProgramWise Revenue Report",
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GetBuilder<HomeController>(
              id: "buttons",
              init: Get.find<HomeController>(),
              builder: (controllerX) {
                PermissionModel formPermissions = Get.find<MainController>()
                    .permissionList!
                    .lastWhere((element) =>
                        element.appFormName == "frmnewprogramwisereport");
                if (controllerX.buttons != null) {
                  return Wrap(
                    spacing: 5,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var btn in controllerX.buttons!)
                        FormButtonWrapper(
                          btnText: btn["name"],
                          callback: Utils.btnAccessHandler2(btn['name'],
                                      controllerX, formPermissions) ==
                                  null
                              ? null
                              : () => formHandler(
                                    btn['name'],
                                  ),
                        )
                    ],
                  );
                }
                return Container(
                  child: Text("No"),
                );
              }),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    ));
  }

  formHandler(String btnName) {
    print(btnName);
    if (btnName == "Clear") {
      // controller.clearPage();
      Get.delete<ProgramWiseRevenueReportController>();
      Get.find<HomeController>().clearPage1();
    } else if (btnName == "Save") {
      // saveValidate();
    } else if (btnName == "Search") {
      // Get.to(
      //   const SearchPage(
      //     key: Key("Booking Status Report"),
      //     screenName: "Booking Status Report",
      //     appBarName: "Booking Status Report",
      //     strViewName: "bms_view_fillermaster",
      //     isAppBarReq: true,
      //   ),
      // );
    }
  }
}
