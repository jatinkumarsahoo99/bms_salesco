import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../controllers/monthly_report_controller.dart';

class MonthlyReportView extends GetView<MonthlyReportController> {
  const MonthlyReportView({Key? key}) : super(key: key);

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

              ///Controllers
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10,
                runSpacing: 10,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                          (val) => controller.selectedLocation = val,
                      "Location",
                      .15,
                      autoFocus: true,
                      selected: controller.selectedLocation,
                      inkWellFocusNode: controller.locationFN,
                    );
                  }),
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.channelList.value,
                          (v) => controller.selectedChannel = v,
                      "Channel",
                      .15,
                      selected: controller.selectedChannel,
                    );
                  }),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.fromDateTC,
                    widthRation: 0.15,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controller.toDateTC,
                    widthRation: 0.15,
                  ),
                  Obx(() {
                    return RadioRow(
                      items: const ["Booking", "Cancelation", "Reschedule"],
                      groupValue: controller.selectedRadio.value,
                      onchange: (val) => controller.selectedRadio.value = val,
                    );
                  }),
                  FormButton(
                      btnText: "Generate",
                      callback: controller.handleGenerateButton)
                ],
              ),

              ///Data table
              Expanded(
                child: Obx(
                      () {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: controller.dataTableList.value.isEmpty
                          ? BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      )
                          : null,
                      child: controller.dataTableList.value.isEmpty
                          ? null
                          : GetBuilder<MonthlyReportController>(
                        assignId: true,
                        id: "grid",
                        builder: (controller) {
                          return DataGridFromMap(
                            mapData: controller.dataTableList.value,
                            widthSpecificColumn: Get.find<HomeController>()
                                .getGridWidthByKey(
                                userGridSettingList:
                                controller.userGridSetting1?.value),
                            onload: (event) {
                              controller.stateManager = event.stateManager;
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormButton(
                      btnText: "Clear",
                      callback: controller.clearPage,
                    ),
                    const SizedBox(width: 10),
                    FormButton(
                        btnText: "Exit",
                        callback: () {
                          Get.find<HomeController>()
                              .postUserGridSetting1(listStateManager: [
                            controller.stateManager,
                          ]);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
