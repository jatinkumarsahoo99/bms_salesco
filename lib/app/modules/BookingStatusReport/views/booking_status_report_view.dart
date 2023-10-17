import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/booking_status_report_controller.dart';

class BookingStatusReportView extends StatelessWidget {
  BookingStatusReportView({Key? key}) : super(key: key);
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
                  (value) {},
                  "Location",
                  0.16,
                  onChanged: (index, selectValue) {
                    controller.locations[index].isSelected = selectValue;
                  },
                  // showData:
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
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Obx(
            () => Container(
              child: controller.dataTableList.value.isEmpty
                  ? null
                  : DataGridShowOnlyKeys(
                      mapData: controller.dataTableList.value,
                      hideCode: false,
                      exportFileName: "BookingStatus Report",
                      onload: (loadevent) {
                        loadevent.stateManager.setSelecting(true);
                        loadevent.stateManager
                            .setSelectingMode(PlutoGridSelectingMode.row);
                      },
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
                        element.appFormName == "frmnewbookingstatus");
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
      Get.delete<BookingStatusReportController>();
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
